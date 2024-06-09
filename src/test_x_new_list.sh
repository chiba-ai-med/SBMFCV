echo "X_new List"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_x_new rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 --resources mem_gb=10 --use-singularity
