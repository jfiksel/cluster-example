#!/bin/bash
#$ -l mem_free=1G
#$ -l h_vmem=1G
#$ -l h_rt=24:00:00
#$ -cwd
module load conda_R
Rscript create-bootstrap-indices.R