# Perform SBMFCV
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbmfcv:main \
-i /work/data/testdata_small.tsv -o /work/output \
--cores=10 --rank_min=2 --rank_max=3 \
--lambda_min=9 --lambda_max=10 --trials=2 \
--n_iter_max=10
