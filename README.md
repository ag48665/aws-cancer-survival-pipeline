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

