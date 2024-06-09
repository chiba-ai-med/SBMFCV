# Perform SBMFCV
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbmfcv:main \
-i /work/data/testdata_small.tsv -o /work/output \
--cores=10 --rank_min=2 --rank_max=3 \
--lambda_min=1 --lambda_max=10 --trials=2 \
--n_iter_max=10 --x_new_list="" \
--input_sparse=FALSE --output_sparse=FALSE \
--x_new_sparse=FALSE --u_new_sparse=FALSE \
--bin=TRUE --beta=2 --ratio=20 --memgb=10
