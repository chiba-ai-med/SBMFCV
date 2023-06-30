# Perform SBMFCV
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbmfcv:main \
-i /work/data/testdata.tsv -o /work/output --memgb=10
