library(SummarizedExperiment)
library(DESeq2)
library(dplyr)
library(pheatmap)

tcga <- readRDS("data/processed/tcga_luad_expression.rds")

counts <- assay(tcga)

metadata <- colData(tcga) %>%
  as.data.frame()

metadata$sample_type <- ifelse(
  metadata$shortLetterCode == "NT",
  "Normal",
  "Tumor"
)

metadata$sample_type <- as.factor(metadata$sample_type)

res_df <- read.csv("results/tables/deseq2_results.csv", row.names = 1)

top_genes <- res_df %>%
  arrange(padj) %>%
  head(50) %>%
  rownames()

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ sample_type
)

dds <- dds[rowSums(counts(dds)) > 10, ]

vsd <- vst(dds, blind = TRUE)

mat <- assay(vsd)[top_genes, ]

annotation_col <- data.frame(
  SampleType = metadata$sample_type
)

rownames(annotation_col) <- colnames(mat)

png("results/figures/top_genes_heatmap.png", width = 1200, height = 1000)

pheatmap(
  mat,
  scale = "row",
  annotation_col = annotation_col,
  show_colnames = FALSE,
  show_rownames = TRUE,
  main = "Top 50 Differentially Expressed Genes"
)

dev.off()

cat("Top genes heatmap generated successfully!\n")