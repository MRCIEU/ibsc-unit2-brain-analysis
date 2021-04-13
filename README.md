# Analysis of brain region GWAS results

To run this analysis first install the necessary packages in R:

```r
install.packages("BiocManager")
BiocManager::install("KEGGREST")
BiocManager::install("KEGGgraph")
remotes::install_github("ieugwasr")
install.packages("pathfindR")
install.packages("tidyverse")
```

Then run the code in `enrichment_analysis.R` (note that it uses the `braingwasresults.csv` file).

