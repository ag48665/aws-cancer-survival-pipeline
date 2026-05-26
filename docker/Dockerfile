FROM rocker/tidyverse:latest

RUN R -e "install.packages(c('BiocManager', 'survival', 'survminer', 'glmnet', 'pheatmap'))"

RUN R -e "BiocManager::install(c('TCGAbiolinks', 'DESeq2', 'SummarizedExperiment'))"

WORKDIR /app

COPY . /app