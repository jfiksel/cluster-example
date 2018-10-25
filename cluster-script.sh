#!/bin/bash
#$ -l mem_free=1G
#$ -l h_vmem=1G
#$ -l h_rt=24:00:00
#$ -cwd
#$ -j y
#$ -R y
#$ -t 1-100
mkdir -p bootstrap-results
output_file="bootstrap-results/run-$SGE_TASK_ID.rds"
if [ ! -f $output_file ]; then
    ### To pass in multiple args, just separate them with a space
    Rscript cluster-script.R $SGE_TASK_ID 
fi;