---
title: Configuration of Seurat environment with renv
date: 2024-02-16
categories: [Programming, R]
tags: [seurat, renv]     # TAG names should always be lowercase
published: true
---

It is not a trivial task to manage R environment. Here is my note for configuration of renv for Seurat analysis.

Because conda env cannot handle all R packages properly and renv cannot manage different versions of R, I decide to make the following strategy:

- conda env for different R versions with the base installation of R.
  - All necessary libraries (not R packages) for compiling R packages need to be installed here.
  - Any R packages installed here is still available in renv environment, but just with lower priority. Therefore, we should keep R installation in conda env as minimal as possible.
- renv manages the project-wise R environment.
  - The renv environment refers to certain R version, but not directly controls it, so we have to it consistent if possible.
  - For any new tasks, we have to generate the renv.lock which includes all the packages needed, and then we just need to ship this renv.lock for reproducing the environment.

## Conda environment

Firstly, I create the conda env for R 4.2.2.

```shell
conda create --name R4.2.2
conda activate R4.2.2
conda install conda-forge::r-base==4.2.2
conda install conda-forge::r-essentials
conda install conda-forge::r-renv
conda install conda-forge::r-biocmanager
```

Because of hdf5r package, I have to install hdf5 into conda env.

```shell
conda install conda-forge::hdf5
```

## Initiate renv environment

Because `renv` stores caches in the local folder, if you want to share these caches with other users, you need to set `RENV_PATHS_ROOT`. By default, this path is set as below:

| Platform | Location     | 
|----------|:-------------|
| Linux | ~/.cache/R/renv |
| macOS | ~/Library/Caches/org.R-project.R/R/renv |
| Windows | %LOCALAPPDATA%/R/cache/R/renv |

For sharing this cache folder with other users, I add this in my .bashrc:

```shell
export RENV_PATHS_ROOT=/data/shared_env/renv
```

Here are some steps I generated renv.lock for scRNAseq analysis. It is important where you initiate renv, because renv will scan all the files inside this directory and automatically install the needed packages. If you want to have a fresh start, just do it in an empty directory.

```R
renv::init()
# You might need to restart R session
renv::install("htmltools", quietly = TRUE)
renv::install("hdf5r", quietly = TRUE)
renv::install("Seurat", quietly = TRUE)
renv::install("mojaveazure/seurat-disk", quietly = TRUE)
renv::install("satijalab/seurat-data", quietly = TRUE)
renv::install("satijalab/azimuth", quietly = TRUE)
renv::install("satijalab/seurat-wrappers", quietly = TRUE)
```

If this is your first time to install those packages, it will take some time, but it will be much faster in the future, because they don't need to be compiled again.

After making sure this environment works with your codes, you need to save it as `renv.lock` file. Please be aware that `renv::snapshot()` will only save the packages you import with `library(PACKAGE)` in your code. If you comment out that line as `# library(PACKAGE)`, `renv::snapshot()` won't save it.

```R
renv::snapshot()
```

Then this `renv.lock` file can be shipped whenever you need it.
 
## Reuse the environment

Whenever you need this environment, you just need to copy `renv.lock` file to the working directory and restore it in your R session.

```R
renv::restore()
```

## Problems

- [Bioconductor packages on github not installing dependencies](https://github.com/rstudio/renv/issues/934)
  ```R
  install.packages("BiocManager")
  options(repos = BiocManager::repositories())
  ```

## References:

- [Introduction to renv](https://rstudio.github.io/renv/articles/renv.html)
- [Path for storing global state](https://rstudio.github.io/renv/reference/paths.html)

