# Expect Error
function catch {
  echo Catch
}
trap catch ERR

# Perform SBMFCV
docker run --rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbmfcv:main \
-i /work/data/negative.tsv -o /work/output_negative --memgb=10

# Error when no error
if [ $? = 0 ]; then
	echo "No error"
	exit 1
fi