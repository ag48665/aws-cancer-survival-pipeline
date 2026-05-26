![R](https://img.shields.io/badge/R-Statistical%20Computing-blue)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue)
![Nextflow](https://img.shields.io/badge/Nextflow-Pipeline-green)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)



\# AWS Cancer Survival Pipeline



Cloud-native bioinformatics pipeline for statistical biomarker validation and survival analysis in lung cancer using TCGA data, R, Nextflow, Docker and AWS.



\## Project Goal



This project demonstrates an end-to-end reproducible workflow for cancer bioinformatics:



\- TCGA clinical and RNA-seq data preparation

\- exploratory statistical analysis

\- survival analysis

\- Cox proportional hazards modeling

\- biomarker validation

\- machine learning model evaluation

\- cloud-ready pipeline design



\## Tech Stack



\- R

\- Nextflow

\- Docker

\- AWS S3 / EC2 / Batch

\- GitHub Actions

\- Shiny



\## Statistical Methods



\- Kaplan-Meier survival curves

\- log-rank test

\- Cox regression

\- multivariate survival modeling

\- bootstrap confidence intervals

\- feature selection

\- model validation



\## Planned Outputs



\- survival curves

\- forest plots

\- volcano plots

\- ROC curves

\- calibration plots

\- interactive dashboard



\## Repository Structure



```text

analysis/      Statistical reports

scripts/       Reusable R scripts

nextflow/      Workflow pipeline

docker/        Reproducible environment

terraform/     Cloud infrastructure

dashboard/     Shiny application

results/       Figures and tables

docs/          Documentation


## Current Results

### Survival Analysis

Kaplan-Meier survival analysis was performed using TCGA-LUAD clinical metadata.

![Kaplan-Meier Survival Plot](results/figures/kaplan_meier_plot.png)

### Cox Regression

A multivariate Cox proportional hazards model was fitted using age and gender.

![Cox Hazard Ratios](results/figures/cox_hazard_ratios.png)

### Differential Expression Analysis

Differential expression analysis was performed using DESeq2 comparing tumor and normal samples.

![Volcano Plot](results/figures/volcano_plot.png)

### PCA

Principal component analysis was performed on variance-stabilized RNA-seq count data.

![PCA Plot](results/figures/pca_plot.png)

### Heatmap

Top differentially expressed genes were visualized using a scaled expression heatmap.

![Top Genes Heatmap](results/figures/top_genes_heatmap.png)

### LASSO Cox Model

LASSO Cox regression was used for survival-associated gene feature selection.

![LASSO Cox Cross-Validation](results/figures/lasso_cox_cv.png)
