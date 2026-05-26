library(SummarizedExperiment)
library(DESeq2)
library(dplyr)
library(ggplot2)

# Load TCGA object
tcga <- readRDS("data/processed/tcga_luad_expression.rds")

# Extract count matrix
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

# Filter low counts
dds <- dds[rowSums(counts(dds)) > 10, ]

# Run differential expression
dds <- DESeq(dds)

# Results
res <- results(dds)

res_df <- as.data.frame(res)

# Remove NA
res_df <- na.omit(res_df)

# Save results
write.csv(
  res_df,
  "results/tables/deseq2_results.csv"
)

# Volcano plot
res_df$significant <- ifelse(
  res_df$padj < 0.05 & abs(res_df$log2FoldChange) > 1,
  "Significant",
  "Not Significant"
)

volcano <- ggplot(
  res_df,
  aes(x = log2FoldChange, y = -log10(padj), color = significant)
) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(
    title = "Differential Expression Volcano Plot",
    x = "Log2 Fold Change",
    y = "-Log10 Adjusted P-value"
  )

ggsave(
  "results/figures/volcano_plot.png",
  volcano,
  width = 10,
  height = 7
)

cat("Differential expression analysis completed successfully!\n")