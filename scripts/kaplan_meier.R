library(survival)
library(survminer)
library(dplyr)

# Load survival dataframe
survival_df <- read.csv(
  "data/processed/survival_dataframe.csv"
)

# Remove missing stage values
survival_df <- survival_df %>%
  filter(!is.na(ajcc_pathologic_stage))

# Create survival object
surv_object <- Surv(
  time = survival_df$survival_time,
  event = survival_df$event
)

# Kaplan-Meier model
fit <- survfit(
  surv_object ~ ajcc_pathologic_stage,
  data = survival_df
)

# Create plot
km_plot <- ggsurvplot(
  fit,
  data = survival_df,
  risk.table = TRUE,
  pval = TRUE,
  conf.int = TRUE,
  ggtheme = theme_minimal(),
  title = "Kaplan-Meier Survival Curves by Cancer Stage",
  xlab = "Days",
  ylab = "Survival Probability"
)

# Save plot
ggsave(
  filename = "results/figures/kaplan_meier_plot.png",
  plot = km_plot$plot,
  width = 10,
  height = 7
)

cat("Kaplan-Meier plot generated successfully!\n")