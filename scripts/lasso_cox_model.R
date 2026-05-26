library(SummarizedExperiment)
library(DESeq2)
library(survival)
library(glmnet)
library(dplyr)

tcga <- readRDS("data/processed/tcga_luad_expression.rds")
survival_df <- read.csv("data/processed/survival_dataframe.csv")

counts <- assay(tcga)
metadata <- colData(tcga) %>% as.data.frame()

metadata$patient_id <- substr(metadata$submitter_id, 1, 12)
survival_df$patient_id <- substr(survival_df$submitter_id, 1, 12)

res_df <- read.csv("results/tables/deseq2_results.csv", row.names = 1)

top_genes <- res_df %>%
  arrange(padj) %>%
  head(100) %>%
  rownames()

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = metadata,
  design = ~ 1
)

dds <- dds[rowSums(counts(dds)) > 10, ]
vsd <- vst(dds, blind = TRUE)

expr <- t(assay(vsd)[top_genes, ])
expr <- as.data.frame(expr)
expr$patient_id <- substr(rownames(expr), 1, 12)

model_df <- inner_join(survival_df, expr, by = "patient_id") %>%
  filter(!is.na(survival_time), survival_time > 0)

x <- as.matrix(model_df[, top_genes])
y <- Surv(model_df$survival_time, model_df$event)

set.seed(123)

cv_fit <- cv.glmnet(
  x,
  y,
  family = "cox",
  alpha = 1,
  nfolds = 5
)

png("results/figures/lasso_cox_cv.png", width = 1000, height = 700)
plot(cv_fit)
dev.off()

coef_lasso <- coef(cv_fit, s = "lambda.min")
selected <- rownames(coef_lasso)[as.numeric(coef_lasso) != 0]

write.csv(
  data.frame(selected_genes = selected),
  "results/tables/lasso_selected_genes.csv",
  row.names = FALSE
)

cat("LASSO Cox model completed successfully!\n")