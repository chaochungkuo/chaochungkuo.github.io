---
title: Conflict in htmltools versions between Seurat and renv
date: 2024-02-13
categories: [Programming, R]
tags: [htmltools, Seurat]     # TAG names should always be lowercase
published: true
---

*renv* (version 1.0.3) uses *htmltools* version 0.5.6.1, but *Seurat v5* uses *htmltools* version 0.5.7. When I initiate a renv project and then install *Seurat*, I encounter an issue as:

```R
/opt/miniconda3/envs/rstudio/lib/R/bin/R --vanilla -s -f '/tmp/RtmphjlHaW/renv-install-1be90932ef38f5.R'
================================================================================

Error in loadNamespace(i, c(lib.loc, .libPaths()), versionCheck = vI[[i]]) : 
  namespace ‘htmltools’ 0.5.6.1 is being loaded, but >= 0.5.7 is required
Calls: loadNamespace -> namespaceImport -> loadNamespace
Execution halted

Error: error testing if 'htmlwidgets' can be loaded [error code 1]
```

My solution is as below:

```R
renv::init(restart=FALSE)
renv::install("htmltools")
renv::snapshot()
renv::restore()
renv::install("Seurat")
```

After reloading the right version of *htmltools*, I can install *Seurat v5* without any problems.
