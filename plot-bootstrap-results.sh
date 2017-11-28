#!/bin/bash
#$ -l mem_free=5G
#$ -l h_vmem=5G
#$ -l h_rt=24:00:00
#$ -cwd
module load conda_R
Rscript plot-bootstrap-results.R