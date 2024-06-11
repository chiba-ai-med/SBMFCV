from snakemake.utils import min_version
import os
import pandas as pd

#################################
# Setting
#################################
# Minimum Version of Snakemake
min_version("7.30.1")

# Required Arguments
INPUT = config["input"]
OUTDIR = config["outdir"]

# Optional Arguments
RANK_MIN = config.get("rank_min", "None")
if RANK_MIN == "None":
	RANK_MIN = 2
else:
	RANK_MIN = int(RANK_MIN)
RANK_MAX = config.get("rank_max", "None")
if RANK_MAX == "None":
	RANK_MAX = 10
else:
	RANK_MAX = int(RANK_MAX)
RANK_INDEX = [str(x) for x in list(range(RANK_MIN, RANK_MAX + 1))]

LAMBDA_MIN = config.get("lambda_min", "None")
if LAMBDA_MIN == "None":
	LAMBDA_MIN = 1
else:
	LAMBDA_MIN = int(LAMBDA_MIN)
LAMBDA_MAX = config.get("lambda_max", "None")
if LAMBDA_MAX == "None":
	LAMBDA_MAX = 10
else:
	LAMBDA_MAX = int(LAMBDA_MAX)
LAMBDA_INDEX = [str(x) for x in list(range(LAMBDA_MIN, LAMBDA_MAX + 1))]

TRIALS = config.get("trials", "None")
if TRIALS == "None":
	TRIALS = 10
else:
	TRIALS = int(TRIALS)
TRIAL_INDEX = [str(x) for x in list(range(1, TRIALS+1))]

N_ITER_MAX = config.get("n_iter_max", "None")
if N_ITER_MAX == "None":
	N_ITER_MAX = 100
else:
	N_ITER_MAX = int(N_ITER_MAX)

X_NEW_LIST = config.get("x_new_list", "None")
if X_NEW_LIST == "None":
	X_NEWS = "_"
else:
	X_NEW_LIST = str(X_NEW_LIST)
	X_NEWS = pd.read_table(X_NEW_LIST, header=None)[0]

INPUT_SPARSE = config.get("input_sparse", "None")
if INPUT_SPARSE == "None":
	INPUT_SPARSE = "FALSE"
else:
	INPUT_SPARSE = str(INPUT_SPARSE)

OUTPUT_SPARSE = config.get("output_sparse", "None")
if OUTPUT_SPARSE == "None":
	OUTPUT_SPARSE = "FALSE"
else:
	OUTPUT_SPARSE = str(OUTPUT_SPARSE)

X_NEW_SPARSE = config.get("x_new_sparse", "None")
if X_NEW_SPARSE == "None":
	X_NEW_SPARSE = "FALSE"
else:
	X_NEW_SPARSE = str(X_NEW_SPARSE)

U_NEW_SPARSE = config.get("u_new_sparse", "None")
if U_NEW_SPARSE == "None":
	U_NEW_SPARSE = "FALSE"
else:
	U_NEW_SPARSE = str(U_NEW_SPARSE)

BIN = config.get("bin", "None")
if BIN == "None":
	BIN = "TRUE"
else:
	BIN = str(BIN)

BETA = config.get("beta", "None")
if BETA == "None":
	BETA = 2
else:
	BETA = int(BETA)

RATIO = config.get("ratio", "None")
if RATIO == "None":
	RATIO = 20
else:
	RATIO = int(RATIO)

# Docker Container
container: 'docker://koki/sbmfcv_component:20240604'

# All Rules
rule all:
	input:
		OUTDIR + '/plot/test_errors.png',
		OUTDIR + '/plot/zero_one_percentage.png',
		OUTDIR + '/U.tsv',
		OUTDIR + '/V.tsv',
		OUTDIR + '/BIN_DATA.tsv',
		OUTDIR + '/U_new'

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
		'src/check_input.sh {input} {output} {INPUT_SPARSE} >& {log}'

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
		'src/nmf.sh {input.in1} {output} {wildcards.rank} {N_ITER_MAX} {BETA} {RATIO} {INPUT_SPARSE} >& {log}'

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
		'src/sbmf.sh {input} {output} {wildcards.l} {N_ITER_MAX} {BIN} {BETA} {INPUT_SPARSE} >& {log}'

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
		'src/aggregate_sbmf.sh {LAMBDA_MIN} {LAMBDA_MAX} {TRIALS} {OUTDIR} {output} {BIN} > {log}'

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
		'src/plot_zero_one_percentage.sh {input} {output} {BIN} > {log}'

rule bestlambda:
	input:
		OUTDIR + '/sbmf/zero_one_percentage.csv'
	output:
		OUTDIR + '/sbmf/bestlambda.txt'
	benchmark:
		OUTDIR + '/benchmarks/bestlambda.txt'
	log:
		OUTDIR + '/logs/bestlambda.log'
	shell:
		'src/bestlambda.sh {input} {output} {BIN} > {log}'

#############################################################
# SBMF with Best Rank and Best Lambda
#############################################################
rule bestrank_bestlambda_sbmf:
	input:
		INPUT,
		OUTDIR + '/nmf/bestrank.txt',
		OUTDIR + '/sbmf/bestlambda.txt'
	output:
		OUTDIR + '/bestrank_bestlambda_sbmf/{t}.RData'
	benchmark:
		OUTDIR + '/benchmarks/bestrank_bestlambda_sbmf_{t}.txt'
	log:
		OUTDIR + '/logs/bestrank_bestlambda_sbmf_{t}.log'
	shell:
		'src/bestrank_bestlambda_sbmf.sh {input} {output} {N_ITER_MAX} {BETA} {INPUT_SPARSE} >& {log}'

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
		'src/bindata_for_landscaper.sh {input} {output} {OUTPUT_SPARSE} > {log}'

#############################################################
# Prediction of U_new from X_new file list
#############################################################
rule check_x_new:
	input:
		OUTDIR + '/V.tsv'
	output:
		OUTDIR + '/{x_new}/CHECK_X_NEW'
	benchmark:
		OUTDIR + '/benchmarks/check_x_new_{x_new}.txt'
	log:
		OUTDIR + '/logs/check_x_new_{x_new}.log'
	shell:
		'src/check_x_new.sh {wildcards.x_new} {input} {output} {X_NEW_SPARSE} >& {log}'

rule predict_u_new:
	input:
		OUTDIR + '/{x_new}/CHECK_X_NEW',
		OUTDIR + '/sbmf/bestlambda.txt',
		OUTDIR + '/V.tsv'
	output:
		OUTDIR + '/{x_new}/U_new'
	benchmark:
		OUTDIR + '/benchmarks/predict_{x_new}.txt'
	log:
		OUTDIR + '/logs/predict_{x_new}.log'
	shell:
		'src/predict_u_new.sh {wildcards.x_new} {input} {output} {N_ITER_MAX} {BETA} {X_NEW_SPARSE} {U_NEW_SPARSE} > {log}'

rule aggregate_u_new:
	input:
		expand(OUTDIR + '/{x_new}/U_new', x_new=X_NEWS)
	output:
		OUTDIR + '/U_new'
	benchmark:
		OUTDIR + '/benchmarks/aggregate_u_new.txt'
	log:
		OUTDIR + '/logs/aggregate_u_new.log'
	shell:
		'src/aggregate_u_new.sh {input} {output} {U_NEW_SPARSE} > {log}'
