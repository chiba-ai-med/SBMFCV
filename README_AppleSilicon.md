# Guideline for M1/M2 Mac users

This README is for M1/M2 Mac users.

In our environment, `Singularity` did not work properly on M1/M2 Mac (2023/1/6).

Therefore, for M1/M2 Mac user, the required tools for `SBMFCV` are not available via the Docker container image file for now.

Instead, all required tools must be installed manually.

Here are the steps we followed on an M1 Mac to install the tools.

Note that this README is not exhaustive enough to solve all possible problems.

## Installation of all pre-requisites

First, we downloaded a shell script to install Mambaforge providing the minimum installer of `mamba` from the Miniforge website.
[https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh](https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh)

Then we performed the shell script as follows:

```bash
bash Mambaforge-MacOSX-arm64.sh
```

After rebooting the shell, we confirmed that the `mamba` command did work as follows:

```
exec $SHELL -l
mamba --version
```

Next, we created a `conda` environment containing the required tools in `SBMFCV` as follows:

```bash
mamba create -c conda-forge -c bioconda -c anaconda -n sbmfcv snakemake -y
```

After activating the conda environment, we confirmed that the `snakemake` command did work as follows:

```bash
mamba activate sbmfcv
snakemake --version
```

## Download this GitHub repository

First, download this GitHub repository and change the working directory.

```bash
git clone https://github.com/chiba-ai-med/SBMFCV.git
cd SBMFCV
```

## Example with local machine

Next, perform `SBMFCV` by the `snakemake` command as follows.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=2 lambda_max=2 lambda_min=2 trials=2 n_iter_max=2.**

**Note that `--use-singularity` option does not work on M1/M2 Mac.**

```bash
snakemake -j 4 --config input=data/testdata.tsv outdir=output rank_min=2 \
rank_max=10 lambda_min=-10 lambda_max=10 trials=10 \
n_iter_max=100 ratio=20 --resources mem_gb=10
```

The meanings of all the arguments are below.

- `-j`: Snakemake option to set [the number of cores](https://snakemake.readthedocs.io/en/stable/executing/cli.html#useful-command-line-arguments) (e.g. 10, mandatory)
- `--config`: Snakemake option to set [the configuration](https://snakemake.readthedocs.io/en/stable/snakefiles/configuration.html) (mandatory)
- `input`: Input file (e.g., testdata.tsv, mandatory)
- `outdir`: Output directory (e.g., output, mandatory)
- `rank_min`: Lower limit of rank parameter to search (e.g., 2, which is used for the rank parameter J of dNMF, mandatory)
- `rank_max`: Upper limit of rank parameter to search (e.g., 10, which is used for the rank parameter J of dNMF, mandatory)
- `lambda_min`: Lower limit of lambda parameter to search (e.g., -10, which means 10^-10 is used for the binary regularization parameter Bin_U of dNMF, mandatory)
- `lambda_max`: Upper limit of lambda parameter to search (e.g., -10, which means 10^10 is used for the binary regularization parameter Bin_U of dNMF, mandatory)
- `trials`: Number of random trials (e.g., 10, mandatory)
- `n_iter_max`: Number of iterations (e.g., 100, mandatory)
- `ratio`: Sampling ratio of cross-validation (0 - 100, e.g., 20, mandatory)
- `--resources`: Snakemake option to control [resources](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html#resources) (optional)
- `mem_gb`: Memory usage (GB, e.g. 10, optional)

## Example with a local machine with Docker

If the `docker` command is available, the following command can be performed without installing any tools.

**Note: To check if the command is executable, set smaller parameters such as rank_min=2 rank_max=2 lambda_max=2 lambda_min=2 trials=2 n_iter_max=2.**

**Note that `--platform linux/amd64` option is required on M1/M2 Mac.**

```bash
docker run --platform Linux/amd64 \
--rm -v $(pwd):/work ghcr.io/chiba-ai-med/sbmfcv:main \
-i /work/data/testdata.tsv -o /work/output \
--cores=4 --rank_min=2 --rank_max=10 \
--lambda_min=-10 --lambda_max=10 --trials=10 \
--n_iter_max=100 --ratio=20 --memgb=10
```

# Authors
- Koki Tsuyuzaki
- Eiryo Kawakami