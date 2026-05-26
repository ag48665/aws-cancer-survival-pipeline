#!/usr/bin/env nextflow

nextflow.enable.dsl=2

workflow {
    println "AWS Cancer Survival Pipeline"
    println "Modules planned:"
    println "- TCGA data download"
    println "- Differential expression analysis"
    println "- Survival analysis"
    println "- Cox regression"
    println "- Model validation"
}