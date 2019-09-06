#!/bin/bash
#$ -l mem_free=1G
#$ -l h_vmem=1G
#$ -l h_rt=24:00:00
#$ -cwd

qsub -N genIndices create-bootstrap-indices.sh
qsub -N bootstrapPar -hold_jid genIndices bootstrap-parallel.sh
qsub -N plotResults -hold_jid bootstrapPar plot-bootstrap-results.sh