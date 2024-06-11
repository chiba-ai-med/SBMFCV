#!/bin/bash
#$ -l nc=4
#$ -p -50
#$ -r yes
#$ -q node.q

#SBATCH -n 4
#SBATCH --nice=50
#SBATCH --requeue
#SBATCH -p node03-06
SLURM_RESTART_COUNT=2

args=("$@")
len=${#args[@]}
INFILES=("${args[@]:0:len-2}")
OUTFILE=("${args[len-2]}")

if [ ${args[len-1]} = "TRUE" ]; then
	# Sparse
	python3 src/aggregate_u_new.py ${INFILES[@]} $OUTFILE
else
	# Dense
	cat ${INFILES[@]} > $OUTFILE
fi
