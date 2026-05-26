library(SummarizedExperiment)
library(DESeq2)
library(dplyr)
library(ggplot2)

# Load TCGA dataset
tcga <- readRDS("data/processed/tcga_luad_expression.rds")

# Extract counts matrix
counts <- assay(tcga)

# Extract metadata
metadata <- colData(tcga) %>%
  as.data.frame()

# Create sample groups
metadata$sample_type <- ifelse(
  metadata$shortLetterCode == "NT",
  "Normal",
  "Tumor"
)

metadata$sample_type <- as.factor(metadata$sample_type)

# Build DESeq dataset
dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ sample_type
)

# Filter low-count genes
dds <- dds[rowSums(counts(dds)) > 10, ]

# Variance stabilizing transformation
vsd <- vst(dds, blind = TRUE)

# PCA
pca_data <- plotPCA(
  vsd,
  intgroup = "sample_type",
  returnData = TRUE
)

percent_var <- round(
  100 * attr(pca_data, "percentVar")
)

# PCA plot
pca_plot <- ggplot(
  pca_data,
  aes(PC1, PC2, color = sample_type)
) +
  geom_point(size = 3, alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "PCA of TCGA-LUAD RNA-seq Samples",
    x = paste0(
      "PC1: ",
      percent_var[1],
      "% variance"
    ),
    y = paste0(
      "PC2: ",
      percent_var[2],
      "% variance"
    ),
    color = "Sample Type"
  )

# Save figure
ggsave(
  "results/figures/pca_plot.png",
  pca_plot,
  width = 9,
  height = 7
)

cat("PCA analysis completed successfully!\n")