---
title: Configuration of Seurat environment with renv
date: 2024-02-14
categories: [Programming, R]
tags: [seurat]     # TAG names should always be lowercase
published: true
---

It is not a trivial task to manage R environment. Here is my note for configuration of renv for Seurat analysis.

First of all, I need to initiate renv and install the packages I need:

```R
renv::init(restart=FALSE)

renv::install("htmltools", quietly = TRUE)
renv::install("hdf5r", quietly = TRUE)
renv::install("Seurat", quietly = TRUE)
renv::install("mojaveazure/seurat-disk", quietly = TRUE)
renv::install("satijalab/seurat-data", quietly = TRUE)
renv::install("satijalab/azimuth", quietly = TRUE)
renv::install("satijalab/seurat-wrappers", quietly = TRUE)
renv::install("stuart-lab/signac", quietly = TRUE)

renv::snapshot()
```

The *htmltools* version conflicts with the one in Seurat, please refer to this post: [Conflict in htmltools versions between Seurat and renv](https://chaochungkuo.github.io/posts/htmltools/).

Installing *hdf5r* has also errors. I have to download *hdf5* by:

```shell
conda install conda-forge::hdf5
```

It will take some time to compile every package for the first time. After everything is installed, we can snapshot this configuration and use this *renv.lock* file whenever we need this environment.

To restore this configuration, just do:

```R
renv::restore()
```
