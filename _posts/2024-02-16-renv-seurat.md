---
title: Configuration of renv environment with R in conda env
date: 2024-02-16
categories: [Programming, R]
tags: [conda, renv]     # TAG names should always be lowercase
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

**When you install packages by renv, ALWAYS make sure where you are installing.**

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

Here I list the problems I encountered as well as its solution.

#### microbiome

Error message:

```error
Error: package 'microbiome' is not available
```

Solution:

```R
options(repos = BiocManager::repositories())
renv::install("microbiome")
```

#### igraph

Error message:

```error
Error: Error installing package 'igraph':
==================================

* installing *source* package ‘igraph’ ...
...
In file included from vendor/cigraph/src/community/optimal_modularity.c:32:
vendor/cigraph/src/internal/glpk_support.h:39:10: fatal error: glpk.h: No such file or directory
   39 | #include <glpk.h>
      |          ^~~~~~~~
compilation terminated.
make: *** [/opt/miniconda3/envs/R4.2.2/lib/R/etc/Makeconf:171: vendor/cigraph/src/community/optimal_modularity.o] Error 1
ERROR: compilation failed for package ‘igraph’
* removing ‘/data/projects/test/renv/staging/1/igraph’
install of package 'igraph' failed [error code 1]
```

Solution:

```shell
conda install conda-forge::glpk
```

And then install igraph again in R:

```R
renv::install("igraph")
```

#### qiime2R

Error message:

```error
Error: package 'qiime2R' is not available
```

Solution:

```R
renv::install("jbisanz/qiime2R")
```

#### textshaping

Error message:

```error
Error: Error installing package 'textshaping':
=======================================

* installing *source* package ‘textshaping’ ...
** package ‘textshaping’ successfully unpacked and MD5 sums checked
** using staged installation
Package harfbuzz was not found in the pkg-config search path.
Perhaps you should add the directory containing `harfbuzz.pc'
to the PKG_CONFIG_PATH environment variable
No package 'harfbuzz' found
Package fribidi was not found in the pkg-config search path.
Perhaps you should add the directory containing `fribidi.pc'
to the PKG_CONFIG_PATH environment variable
No package 'fribidi' found
Using PKG_CFLAGS=
Using PKG_LIBS=-lfreetype -lharfbuzz -lfribidi -lpng
--------------------------- [ANTICONF] --------------------------------
Configuration failed to find the harfbuzz freetype2 fribidi library. Try installing:
 * deb: libharfbuzz-dev libfribidi-dev (Debian, Ubuntu, etc)
 * rpm: harfbuzz-devel fribidi-devel (Fedora, EPEL)
 * csw: libharfbuzz_dev libfribidi_dev (Solaris)
 * brew: harfbuzz fribidi (OSX)
If harfbuzz freetype2 fribidi is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a harfbuzz freetype2 fribidi.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
-------------------------- [ERROR MESSAGE] ---------------------------
<stdin>:1:10: fatal error: hb-ft.h: No such file or directory
compilation terminated.
--------------------------------------------------------------------
ERROR: configuration failed for package ‘textshaping’
```

Solution:

```shell
sudo apt install libharfbuzz-dev libfribidi-dev libfontconfig1-dev
```

#### ragg

```error
Error: Error installing package 'ragg':
================================

* installing *source* package ‘ragg’ ...
** package ‘ragg’ successfully unpacked and MD5 sums checked
** using staged installation
Found pkg-config cflags and libs!
Using PKG_CFLAGS=-I/usr/include/freetype2 -I/usr/include/libpng16 -I/usr/include/x86_64-linux-gnu
Using PKG_LIBS=-lfreetype -lpng16 -lz -ltiff -ljpeg -ljpeg
-----------------------------[ ANTICONF ]-------------------------------
Configuration failed to find one of freetype2 libpng libtiff-4 libjpeg. Try installing:
 * deb: libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev (Debian, Ubuntu, etc)
 * rpm: freetype-devel libpng-devel libtiff-devel libjpeg-devel (Fedora, CentOS, RHEL)
 * csw: libfreetype_dev libpng16_dev libtiff_dev libjpeg_dev (Solaris)
If freetype2 libpng libtiff-4 libjpeg is already installed, check that 'pkg-config' is in your
PATH and PKG_CONFIG_PATH contains a freetype2 libpng libtiff-4 libjpeg.pc file. If pkg-config
is unavailable you can set INCLUDE_DIR and LIB_DIR manually via:
R CMD INSTALL --configure-vars='INCLUDE_DIR=... LIB_DIR=...'
...
ERROR: configuration failed for package ‘ragg’
* removing ‘/data/projects/test/renv/staging/1/ragg’
install of package 'ragg' failed [error code 1]
```

Solution:

```shell
sudo apt install libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev
conda install -c conda-forge pkg-config
```

See this [discussion](https://stackoverflow.com/questions/68824450/error-configuration-failed-for-package-ragg).

#### Rmpfr

```error
* installing *source* package ‘Rmpfr’ ...
** package ‘Rmpfr’ successfully unpacked and MD5 sums checked
** using staged installation
checking for gcc... x86_64-conda-linux-gnu-cc
checking whether the C compiler works... yes
checking for C compiler default output file name... a.out
checking for suffix of executables...
checking whether we are cross compiling... no
checking for suffix of object files... o
checking whether we are using the GNU C compiler... yes
checking whether x86_64-conda-linux-gnu-cc accepts -g... yes
checking for x86_64-conda-linux-gnu-cc option to accept ISO C89... none needed
checking how to run the C preprocessor... x86_64-conda-linux-gnu-cc -E
checking for grep that handles long lines and -e... /usr/bin/grep
checking for egrep... /usr/bin/grep -E
checking for ANSI C header files... yes
checking for sys/types.h... yes
checking for sys/stat.h... yes
checking for stdlib.h... yes
checking for string.h... yes
checking for memory.h... yes
checking for strings.h... yes
checking for inttypes.h... yes
checking for stdint.h... yes
checking for unistd.h... yes
checking mpfr.h usability... no
checking mpfr.h presence... no
checking for mpfr.h... no
configure: error: Header file mpfr.h not found; maybe use --with-mpfr-include=INCLUDE_PATH
ERROR: configuration failed for package ‘Rmpfr’
* removing ‘/data/projects/test/renv/staging/1/Rmpfr’
install of package 'Rmpfr' failed [error code 1]
```

Solution:

```shell
conda install conda-forge::mpfr
```



## References:

- [Introduction to renv](https://rstudio.github.io/renv/articles/renv.html)
- [Path for storing global state](https://rstudio.github.io/renv/reference/paths.html)
- [Bioconductor packages on github not installing dependencies](https://github.com/rstudio/renv/issues/934)
