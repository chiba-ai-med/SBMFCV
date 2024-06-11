echo "X_new List (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_x_new rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "X_new List (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_x_new2 rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 --resources mem_gb=10 --use-singularity
