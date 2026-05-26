library(SummarizedExperiment)
library(dplyr)

# Load prepared TCGA object
tcga <- readRDS("data/processed/tcga_luad_expression.rds")

# Extract clinical metadata
clinical <- colData(tcga) %>%
  as.data.frame()

# Build survival dataframe
survival_df <- clinical %>%
  dplyr::select(
    submitter_id,
    vital_status,
    days_to_death,
    days_to_last_follow_up,
    age_at_index,
    gender,
    ajcc_pathologic_stage
  )

# Create survival time
survival_df$survival_time <- ifelse(
  is.na(survival_df$days_to_death),
  survival_df$days_to_last_follow_up,
  survival_df$days_to_death
)

# Create event variable
survival_df$event <- ifelse(
  survival_df$vital_status == "Dead",
  1,
  0
)

# Remove missing values
survival_df <- survival_df %>%
  filter(!is.na(survival_time))

# Save
write.csv(
  survival_df,
  "data/processed/survival_dataframe.csv",
  row.names = FALSE
)

cat("Survival dataframe created successfully!\n")