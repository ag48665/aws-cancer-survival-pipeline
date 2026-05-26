# TCGA LUAD data download script

if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

packages <- c("TCGAbiolinks", "SummarizedExperiment")

for (pkg in packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    BiocManager::install(pkg)
  }
}

library(TCGAbiolinks)
library(SummarizedExperiment)

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

query <- GDCquery(
  project = "TCGA-LUAD",
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
)

GDCdownload(
  query,
  method = "api",
  files.per.chunk = 5,
  directory = "data/raw"
)

data <- GDCprepare(
  query,
  directory = "data/raw"
)

saveRDS(data, file = "data/processed/tcga_luad_expression.rds")

cat("TCGA LUAD data downloaded and prepared successfully!\n")