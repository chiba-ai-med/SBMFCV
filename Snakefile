from snakemake.utils import min_version
import os

#################################
# Setting
#################################
# Minimum Version of Snakemake
min_version("7.30.1")

# Required Arguments
INPUT = config["input"]
OUTDIR = config["outdir"]

# Optional Arguments
RANK_MIN = int(config["rank_min"])
RANK_MAX = int(config["rank_max"])
RANK_INDEX = [str(x) for x in list(range(RANK_MIN, RANK_MAX + 1))]
LAMBDA_MIN = int(config["lambda_min"])
LAMBDA_MAX = int(config["lambda_max"])
LAMBDA_INDEX = [str(x) for x in list(range(LAMBDA_MIN, LAMBDA_MAX + 1))]
TRIALS = int(config["trials"])
TRIAL_INDEX = [str(x) for x in list(range(1, TRIALS+1))]
N_ITER_MAX = int(config["n_iter_max"])
RATIO = int(config["ratio"])

# Docker Container
container: 'docker://koki/sbmfcv_component:20230629'

# All Rules
rule all:
	input:
		OUTDIR + '/plot/test_errors.png',
		OUTDIR + '/plot/zero_one_percentage.png',
		OUTDIR + '/U.tsv',
		OUTDIR + '/V.tsv',
		OUTDIR + '/BIN_DATA.tsv'

#############################################################
# Non-negative Check
#############################################################
rule check_input:
	input:
		INPUT
	output:
		OUTDIR + '/CHECK_NONNEGATIVE'
	benchmark:
		OUTDIR + '/benchmarks/check_input.txt'
	log:
		OUTDIR + '/logs/check_input.log'
	shell:
		'src/check_input.sh {input} {output} >& {log}'

#############################################################
# Rank Estimation
#############################################################
rule nmf:
	input:
		in1=INPUT,
		in2=OUTDIR + '/CHECK_NONNEGATIVE'
	output:
		OUTDIR + '/nmf/{rank}/{t}_error.txt',
		OUTDIR + '/nmf/{rank}/{t}.RData'
	benchmark:
		OUTDIR + '/benchmarks/nmf_{rank}_{t}.txt'
	log:
		OUTDIR + '/logs/nmf_{rank}_{t}.log'
	shell:
		'src/nmf.sh {input.in1} {output} {wildcards.rank} {N_ITER_MAX} {RATIO} >& {log}'

rule aggregate_nmf:
	input:
		expand(OUTDIR + '/nmf/{rank}/{t}_error.txt',
			rank=RANK_INDEX, t=TRIAL_INDEX)
	output:
		OUTDIR + '/nmf/test_errors.csv'
	benchmark:
		OUTDIR + '/benchmarks/aggregate_nmf.txt'
	log:
		OUTDIR + '/logs/aggregate_nmf.log'
	shell:
		'src/aggregate_nmf.sh {RANK_MIN} {RANK_MAX} {TRIALS} {OUTDIR} {output} > {log}'

rule plot_test_error:
	input:
		OUTDIR + '/nmf/test_errors.csv'
	output:
		OUTDIR + '/plot/test_errors.png'
	benchmark:
		OUTDIR + '/benchmarks/plot_test_error.txt'
	log:
		OUTDIR + '/logs/plot_test_error.log'
	shell:
		'src/plot_test_error.sh {input} {output} > {log}'

rule bestrank:
	input:
		OUTDIR + '/nmf/test_errors.csv'
	output:
		OUTDIR + '/nmf/bestrank.txt'
	benchmark:
		OUTDIR + '/benchmarks/bestrank.txt'
	log:
		OUTDIR + '/logs/bestrank.log'
	shell:
		'src/bestrank.sh {input} {output} > {log}'

#############################################################
# Binary Regularization Parameter (Lambda) Estimation
#############################################################
rule sbmf:
	input:
		INPUT,
		OUTDIR + '/nmf/bestrank.txt'
	output:
		OUTDIR + '/sbmf/{l}/{t}_error.txt',
		OUTDIR + '/sbmf/{l}/{t}.RData'
	benchmark:
		OUTDIR + '/benchmarks/sbmf_{l}_{t}.txt'
	log:
		OUTDIR + '/logs/sbmf_{l}_{t}.log'
	shell:
		'src/sbmf.sh {input} {output} {wildcards.l} {N_ITER_MAX} >& {log}'

rule aggregate_sbmf:
	input:
		expand(OUTDIR + '/sbmf/{l}/{t}_error.txt',
			l=LAMBDA_INDEX, t=TRIAL_INDEX)
	output:
		OUTDIR + '/sbmf/zero_one_percentage.csv'
	benchmark:
		OUTDIR + '/benchmarks/aggregate_sbmf.txt'
	log:
		OUTDIR + '/logs/aggregate_sbmf.log'
	shell:
		'src/aggregate_sbmf.sh {LAMBDA_MIN} {LAMBDA_MAX} {TRIALS} {OUTDIR} {output} > {log}'

rule plot_zero_one_percentage:
	input:
		OUTDIR + '/sbmf/zero_one_percentage.csv'
	output:
		OUTDIR + '/plot/zero_one_percentage.png'
	benchmark:
		OUTDIR + '/benchmarks/plot_zero_one_percentage.txt'
	log:
		OUTDIR + '/logs/plot_zero_one_percentage.log'
	shell:
		'src/plot_zero_one_percentage.sh {input} {output} > {log}'

rule bestlambda:
	input:
		OUTDIR + '/sbmf/zero_one_percentage.csv'
	output:
		OUTDIR + '/snmf/bestlambda.txt'
	benchmark:
		OUTDIR + '/benchmarks/bestlambda.txt'
	log:
		OUTDIR + '/logs/bestlambda.log'
	shell:
		'src/bestlambda.sh {input} {output} > {log}'

#############################################################
# SBMF with Best Rank and Best Lambda
#############################################################
rule bestrank_bestlambda_sbmf:
	input:
		INPUT,
		OUTDIR + '/nmf/bestrank.txt',
		OUTDIR + '/snmf/bestlambda.txt'
	output:
		OUTDIR + '/bestrank_bestlambda_sbmf/{t}.RData'
	benchmark:
		OUTDIR + '/benchmarks/bestrank_bestlambda_sbmf_{t}.txt'
	log:
		OUTDIR + '/logs/bestrank_bestlambda_sbmf_{t}.log'
	shell:
		'src/bestrank_bestlambda_sbmf.sh {input} {output} {N_ITER_MAX} >& {log}'

rule aggregate_bestrank_bestlambda_sbmf:
	input:
		expand(OUTDIR + '/bestrank_bestlambda_sbmf/{t}.RData',
			t=TRIAL_INDEX)
	output:
		OUTDIR + '/bestrank_bestlambda_sbmf/rec_error.csv'
	benchmark:
		OUTDIR + '/benchmarks/aggregate_bestrank_bestlambda_sbmf.txt'
	log:
		OUTDIR + '/logs/aggregate_bestrank_bestlambda_sbmf.log'
	shell:
		'src/aggregate_bestrank_bestlambda_sbmf.sh {TRIALS} {OUTDIR} {output} > {log}'

#############################################################
# Best rank, Best lamdba, Best trial
#############################################################
rule b3:
	input:
		OUTDIR + '/bestrank_bestlambda_sbmf/rec_error.csv'
	output:
		OUTDIR + '/U.tsv',
		OUTDIR + '/V.tsv'
	benchmark:
		OUTDIR + '/benchmarks/b3.txt'
	log:
		OUTDIR + '/logs/b3.log'
	shell:
		'src/b3.sh {input} {output} > {log}'

rule bindata_for_landscaper:
	input:
		OUTDIR + '/U.tsv'
	output:
		OUTDIR + '/BIN_DATA.tsv'
	benchmark:
		OUTDIR + '/benchmarks/bindata_for_landscaper.txt'
	log:
		OUTDIR + '/logs/bindata_for_landscaper.log'
	shell:
		'src/bindata_for_landscaper.sh {input} {output} > {log}'
