# dddd
echo "Input (Dense) / Output (Dense) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xdddd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ddds
echo "Input (Dense) / Output (Dense) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xddds rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ddsd
echo "Input (Dense) / Output (Dense) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xddsd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ddss
echo "Input (Dense) / Output (Dense) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xddss rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=FALSE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dsdd
echo "Input (Dense) / Output (Sparse) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xdsdd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dsds
echo "Input (Dense) / Output (Sparse) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xdsds rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dssd
echo "Input (Dense) / Output (Sparse) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xdssd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# dsss
echo "Input (Dense) / Output (Sparse) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_small.tsv outdir=output_xdsss rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=FALSE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sddd
echo "Input (Sparse) / Output (Dense) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xsddd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sdds
echo "Input (Sparse) / Output (Dense) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xsdds rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sdsd
echo "Input (Sparse) / Output (Dense) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xsdsd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sdss
echo "Input (Sparse) / Output (Dense) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xsdss rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=TRUE output_sparse=FALSE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ssdd
echo "Input (Sparse) / Output (Sparse) / X_new (Dense) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xssdd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ssds
echo "Input (Sparse) / Output (Sparse) / X_new (Dense) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xssds rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=FALSE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# sssd
echo "Input (Sparse) / Output (Sparse) / X_new (Sparse) / U_new (Dense)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xsssd rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=FALSE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity

# ssss
echo "Input (Sparse) / Output (Sparse) / X_new (Sparse) / U_new (Sparse)"
snakemake -j 10 --config input=data/testdata_sparse.tsv outdir=output_xssss rank_min=2 \
rank_max=3 lambda_min=9 lambda_max=10 trials=2 \
n_iter_max=10 x_new_list="data/x_new_list_sparse.txt" \
input_sparse=TRUE output_sparse=TRUE \
x_new_sparse=TRUE u_new_sparse=TRUE \
bin=TRUE beta=2 ratio=20 \
--resources mem_gb=10 --use-singularity
