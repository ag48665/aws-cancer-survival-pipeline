# AWS Cancer Survival Pipeline

![R](https://img.shields.io/badge/R-Statistical%20Computing-blue)
![Docker](https://img.shields.io/badge/Docker-Containerized-blue)
![Nextflow](https://img.shields.io/badge/Nextflow-Pipeline-green)
![AWS](https://img.shields.io/badge/AWS-Cloud-orange)

Cloud-ready bioinformatics pipeline for RNA-seq statistical analysis, biomarker discovery, and survival modeling in lung cancer using TCGA data.

## Overview

This project demonstrates an end-to-end reproducible workflow for cancer bioinformatics and biostatistics:

- TCGA RNA-seq and clinical data processing
- differential expression analysis with DESeq2
- exploratory transcriptomic analysis
- Kaplan-Meier survival analysis
- Cox proportional hazards modeling
- LASSO Cox feature selection
- reproducible pipeline structure with Docker, Nextflow, and GitHub Actions

---
## Current Results

### Kaplan-Meier Survival Analysis

Survival curves were generated using TCGA-LUAD clinical metadata.

![Kaplan-Meier Survival Plot](https://raw.githubusercontent.com/ag48665/aws-cancer-survival-pipeline/main/results/figures/kaplan_meier_plot.png)

---

### Cox Regression

A Cox proportional hazards model was fitted using clinical covariates.

![Cox Hazard Ratios](https://raw.githubusercontent.com/ag48665/aws-cancer-survival-pipeline/main/results/figures/cox_hazard_ratios.png)

---

### Differential Expression Analysis

Differential expression analysis was performed using DESeq2 to compare tumor and normal RNA-seq samples.

![Volcano Plot](https://raw.githubusercontent.com/ag48665/aws-cancer-survival-pipeline/main/results/figures/volcano_plot.png)

---

### Principal Component Analysis

PCA was performed on variance-stabilized RNA-seq count data.

![PCA Plot](https://raw.githubusercontent.com/ag48665/aws-cancer-survival-pipeline/main/results/figures/pca_plot.png)

---

### LASSO Cox Model

LASSO Cox regression was used for survival-associated gene feature selection.

![LASSO Cox Cross-Validation](https://raw.githubusercontent.com/ag48665/aws-cancer-survival-pipeline/main/results/figures/lasso_cox_cv.png)
---

## Tech Stack

- R
- Bioconductor
- DESeq2
- TCGAbiolinks
- survival
- survminer
- glmnet
- ggplot2
- pheatmap
- Nextflow
- Docker
- GitHub Actions
- AWS-ready project structure

---

## Repository Structure

```text
analysis/      Statistical reports
scripts/       Reusable R analysis scripts
nextflow/      Workflow pipeline skeleton
docker/        Reproducible Docker environment
terraform/     Cloud infrastructure placeholder
dashboard/     Future Shiny dashboard
results/       Figures and result tables
docs/          Documentation and diagrams
```

---

## Pipeline Architecture

```text
TCGA-LUAD Data
      |
      v
Data Download & Preprocessing
      |
      v
RNA-seq Count Matrix + Clinical Metadata
      |
      v
Statistical Analysis
      |
      +--> Differential Expression Analysis
      +--> PCA
      +--> Heatmap
      +--> Kaplan-Meier Survival Analysis
      +--> Cox Regression
      +--> LASSO Cox Feature Selection
      |
      v
Figures, Tables, and Reproducible Reports
```

---
