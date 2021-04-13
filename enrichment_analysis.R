library(ieugwasr)
library(tidyverse)
library(pathfindR)

a <- read.csv("braingwasresults.csv")

nearest_gene_info <- unique(a$rsid) %>%
	ieugwasr::variants_rsid()

nearest_gene_info <- nearest_gene_info %>%
	dplyr::mutate(
		gene = geneinfo %>%
			strsplit(., split=":") %>%
			sapply(., function(x) x[1])
	) %>%
	dplyr::mutate(
		gene = dplyr::case_when(
			gene != "." ~ gene
		)
	)

input_df <- dplyr::select(nearest_gene_info, rsid=query, Gene.symbol=gene) %>%
	filter(!is.na(Gene.symbol)) %>%
	inner_join(
		.,
		dplyr::select(a, rsid, logFC = beta, adj.P.Val=pvalue),
		by="rsid"
	) %>%
	dplyr::select(-c(rsid)) %>%
	dplyr::arrange(adj.P.Val) %>%
	dplyr::filter(!duplicated(Gene.symbol)) %>%
	as.data.frame()

result <- run_pathfindR(input_df)
