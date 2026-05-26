# TCGA data download script

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# Install packages if missing
packages <- c("TCGAbiolinks", "SummarizedExperiment")

for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
        BiocManager::install(pkg)
    }
}

library(TCGAbiolinks)
library(SummarizedExperiment)

# Create query
query <- GDCquery(
    project = "TCGA-LUAD",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "HTSeq - Counts"
)

# Download data
GDCdownload(query)

# Prepare expression matrix
data <- GDCprepare(query)

# Save object
saveRDS(data, file = "data/processed/tcga_luad_expression.rds")

cat("TCGA LUAD data downloaded successfully!\n")