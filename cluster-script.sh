#!/bin/bash
#$ -l mem_free=5G
#$ -l h_vmem=5G
#$ -l h_rt=24:00:00
#$ -cwd
#$ -j y
#$ -R y
#$ -t 1-100
mkdir -p bootstrap-results
output_file="bootstrap-results/run-$SGE_TASK_ID.rds"
module load conda_R
if [ ! -f $output_file ]; then
    Rscript cluster-script.R --i $SGE_TASK_ID 
fi;