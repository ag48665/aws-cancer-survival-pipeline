library(survival)
library(dplyr)

survival_df <- read.csv("data/processed/survival_dataframe.csv")

survival_df <- survival_df %>%
  filter(
    !is.na(survival_time),
    !is.na(event),
    !is.na(age_at_index),
    !is.na(gender),
    survival_time > 0
  )

survival_df$gender <- as.factor(survival_df$gender)

cox_model <- coxph(
  Surv(survival_time, event) ~ age_at_index + gender,
  data = survival_df
)

cox_summary <- summary(cox_model)

cox_table <- data.frame(
  variable = rownames(cox_summary$coefficients),
  hazard_ratio = cox_summary$coefficients[, "exp(coef)"],
  lower_95_ci = cox_summary$conf.int[, "lower .95"],
  upper_95_ci = cox_summary$conf.int[, "upper .95"],
  p_value = cox_summary$coefficients[, "Pr(>|z|)"]
)

write.csv(
  cox_table,
  "results/tables/cox_model_results.csv",
  row.names = FALSE
)

png("results/figures/cox_hazard_ratios.png", width = 1000, height = 700)

plot(
  cox_table$hazard_ratio,
  seq_along(cox_table$hazard_ratio),
  xlim = range(c(cox_table$lower_95_ci, cox_table$upper_95_ci)),
  pch = 19,
  yaxt = "n",
  xlab = "Hazard Ratio",
  ylab = "",
  main = "Cox Regression Hazard Ratios"
)

arrows(
  cox_table$lower_95_ci,
  seq_along(cox_table$hazard_ratio),
  cox_table$upper_95_ci,
  seq_along(cox_table$hazard_ratio),
  angle = 90,
  code = 3,
  length = 0.05
)

abline(v = 1, lty = 2)

axis(
  2,
  at = seq_along(cox_table$hazard_ratio),
  labels = cox_table$variable,
  las = 1
)

dev.off()

sink("results/tables/cox_model_summary.txt")
print(cox_summary)
sink()

cat("Cox regression analysis completed successfully!\n")