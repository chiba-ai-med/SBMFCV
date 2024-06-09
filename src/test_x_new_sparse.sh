# dddd
echo "Input (Dense) / Output (Dense) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_dddd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ddds
echo "Input (Dense) / Output (Dense) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_ddds rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ddsd
echo "Input (Dense) / Output (Dense) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_ddsd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ddss
echo "Input (Dense) / Output (Dense) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_ddss rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dsdd
echo "Input (Dense) / Output (Sparse) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_dsdd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dsds
echo "Input (Dense) / Output (Sparse) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_dsds rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dssd
echo "Input (Dense) / Output (Sparse) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_dssd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dsss
echo "Input (Dense) / Output (Sparse) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_dsss rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sddd
echo "Input (Sparse) / Output (Dense) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_sddd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sdds
echo "Input (Sparse) / Output (Dense) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_sdds rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sdsd
echo "Input (Sparse) / Output (Dense) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_sdsd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sdss
echo "Input (Sparse) / Output (Dense) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_sdss rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ssdd
echo "Input (Sparse) / Output (Sparse) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_ssdd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ssds
echo "Input (Sparse) / Output (Sparse) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_ssds rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sssd
echo "Input (Sparse) / Output (Sparse) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_sssd rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ssss
echo "Input (Sparse) / Output (Sparse) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_ssss rank_min=2 \
rank_max=3 lambda_min=1 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity
