echo "Binarization"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_bin rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 --resources mem_gb=10 --use-singularity

echo "Not Binarization"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_notbin rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=FALSE beta=2 ratio=20 --resources mem_gb=10 --use-singularity
