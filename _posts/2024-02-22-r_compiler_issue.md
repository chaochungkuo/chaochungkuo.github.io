---
title: An issue in R in compiling packages
date: 2024-02-22
categories: [Programming, R]
tags: [renv, rstudio]  # TAG names should always be lowercase
published: true
---

## Problem

I installed R in the conda environment and use RStudio Server to code R on an Ubuntu server. I have set all the environmental variables for Renv, but I still encounter the issue below sometimes (not always):

```error
renv::install("org.Mm.eg.db")
# Downloading packages -------------------------------------------------------
- Downloading org.Mm.eg.db from BioCann ...     OK [file is up to date]
- Downloading AnnotationDbi from BioCsoft ...   OK [file is up to date]
- Downloading Biobase from BioCsoft ...         OK [file is up to date]
- Downloading IRanges from BioCsoft ...         OK [file is up to date]
- Downloading S4Vectors from BioCsoft ...       OK [file is up to date]
- Downloading KEGGREST from BioCsoft ...        OK [file is up to date]
- Downloading Biostrings from BioCsoft ...      OK [file is up to date]
- Downloading XVector from BioCsoft ...         OK [file is up to date]
- Downloading zlibbioc from BioCsoft ...        OK [file is up to date]
- Downloading GenomeInfoDb from BioCsoft ...    OK [file is up to date]
Successfully downloaded 10 packages in 9.4 seconds.

The following package(s) will be installed:
- AnnotationDbi [1.64.1]
- Biobase       [2.62.0]
- Biostrings    [2.70.2]
- GenomeInfoDb  [1.38.6]
- IRanges       [2.36.0]
- KEGGREST      [1.42.0]
- org.Mm.eg.db  [3.18.0]
- S4Vectors     [0.40.2]
- XVector       [0.42.0]
- zlibbioc      [1.48.0]
These packages will be installed into "/data/projects/231129_Moellmann_Lehrke_MedI_mRNAseq/analysis/functional_analyses/renv/library/R-4.3/x86_64-conda-linux-gnu".

Do you want to proceed? [Y/n]: Y

# Installing packages --------------------------------------------------------
- Installing Biobase ...                        FAILED
Error: Error installing package 'Biobase':
===================================

* installing *source* package ‘Biobase’ ...
** using staged installation
** libs
sh: 1: x86_64-conda-linux-gnu-cc: not found
x86_64-conda-linux-gnu-cc -I"/opt/miniconda3/envs/R4.3.2/lib/R/include" -DNDEBUG   -DNDEBUG -D_FORTIFY_SOURCE=2 -O2 -isystem /opt/miniconda3/envs/R4.3.2/include -I/opt/miniconda3/envs/R4.3.2/include -Wl,-rpath-link,/opt/miniconda3/envs/R4.3.2/lib    -fpic  -march=nocona -mtune=haswell -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -O2 -ffunction-sections -pipe -isystem /opt/miniconda3/envs/R4.3.2/include -fdebug-prefix-map=/home/conda/feedstock_root/build_artifacts/r-base-split_1706308578445/work=/usr/local/src/conda/r-base-4.3.2 -fdebug-prefix-map=/opt/miniconda3/envs/R4.3.2=/usr/local/src/conda-prefix  -c Rinit.c -o Rinit.o
/bin/sh: 1: x86_64-conda-linux-gnu-cc: not found
make: *** [/opt/miniconda3/envs/R4.3.2/lib/R/etc/Makeconf:193: Rinit.o] Error 127
ERROR: compilation failed for package ��Biobase’
* removing ‘/data/projects/231129_Moellmann_Lehrke_MedI_mRNAseq/analysis/functional_analyses/renv/staging/1/Biobase’
install of package 'Biobase' failed [error code 1]
```

The most important information here is this line:
```sh: 1: x86_64-conda-linux-gnu-cc: not found```

This R session cannot find the compiler, although I can use it in my terminal. And I do see this file in the bin folder of my conda env.

## Not able to repeat the problem in terminal

Then I tested the same installation in another R session activated in the terminal, not R console in Rstudio. It works just fine. The difference results of the R sessions between RStudio console and R session in the terminal puzzles me.

I run the command below to check their variables:

```R
.libPaths()
Sys.getenv("RENV_PATHS_ROOT")
Sys.getenv("RENV_PATHS_LIBRARY")
Sys.getenv("RENV_PATHS_LIBRARY_ROOT")
Sys.getenv("RENV_PATHS_LIBRARY_STAGING")
Sys.getenv("RENV_PATHS_SANDBOX")
Sys.getenv("RENV_PATHS_LOCKFILE")
Sys.getenv("RENV_PATHS_CELLAR")
Sys.getenv("RENV_PATHS_SOURCE")
Sys.getenv("RENV_PATHS_BINARY")
Sys.getenv("RENV_PATHS_CACHE")
Sys.getenv("RENV_PATHS_PREFIX")
Sys.getenv("RENV_PATHS_RENV")
Sys.getenv("RENV_PATHS_RTOOLS")
Sys.getenv("RENV_PATHS_EXTSOFT")
```

In RStudio console, I got the results below:

```R
> .libPaths()
[1] "/data/projects/231129_Moellmann_Lehrke_MedI_mRNAseq/analysis/functional_analyses/renv/library/R-4.3/x86_64-conda-linux-gnu"
[2] "/home/ckuo/.cache/R/renv/sandbox/R-4.3/x86_64-conda-linux-gnu/3ed62db4"                                                    
> Sys.getenv("RENV_PATHS_ROOT")
[1] ""
> Sys.getenv("RENV_PATHS_LIBRARY")
[1] ""
> Sys.getenv("RENV_PATHS_LIBRARY_ROOT")
[1] ""
> Sys.getenv("RENV_PATHS_LIBRARY_STAGING")
[1] ""
> Sys.getenv("RENV_PATHS_SANDBOX")
[1] ""
> Sys.getenv("RENV_PATHS_LOCKFILE")
[1] ""
> Sys.getenv("RENV_PATHS_CELLAR")
[1] ""
> Sys.getenv("RENV_PATHS_SOURCE")
[1] ""
> Sys.getenv("RENV_PATHS_BINARY")
[1] ""
> Sys.getenv("RENV_PATHS_CACHE")
[1] ""
> Sys.getenv("RENV_PATHS_PREFIX")
[1] ""
> Sys.getenv("RENV_PATHS_RENV")
[1] ""
> Sys.getenv("RENV_PATHS_RTOOLS")
[1] ""
> Sys.getenv("RENV_PATHS_EXTSOFT")
[1] ""
```

And in the R session activated in the terminal, I got something different:

```R
[1] "/data/projects/231129_Moellmann_Lehrke_MedI_mRNAseq/analysis/functional_analyses/renv/library/R-4.3/x86_64-conda-linux-gnu"
[2] "/opt/miniconda3/envs/R4.3.2/lib/R/library"                                                                                 
[1] "/data/shared_env/renv"
[1] ""
[1] ""
[1] ""
[1] ""
[1] ""
[1] ""
[1] ""
[1] ""
[1] "/data/shared_env/renv/cache"
[1] ""
[1] ""
[1] ""
[1] ""
```

## Conclusion

Somehow, the R console in Rstudio doesn't catch those environmental variables. It does sometimes, but not always. Although I have set the following line in `.bashrc`:

```shell
export R_PROFILE_USER=/data/shared_env/init_script.R
```

With `init_script.R` file below:

```R
Sys.setenv(RENV_PATHS_ROOT = "/data/shared_env/renv/")
Sys.setenv(RENV_PATHS_CACHE = "/data/shared_env/renv/cache/")
```

I still cannot make RStudio Server to globally load these scripts.

In short, my solution now is to add this line in every Rmd when I want to use the global cache.

```R
Sys.setenv(RENV_PATHS_ROOT = "/data/shared_env/renv/")
```
