---
title: Generate chunks of codes in Rmd
date: 2024-02-26
categories: [Programming, R]
tags: [rmd]  # TAG names should always be lowercase
published: true
---

This is a note on how to generate code chunks in Rmd by looping through the data.

```R
```{r, echo=FALSE, results='asis', warning=FALSE, message=FALSE}
for (i in 1:50) {
  cat("\n### ",  msig_gsea$pathway[i], "\n")
  p <- plotEnrichment(pathways[[msig_gsea$pathway[i]]], geneList)
  print(p)
  cat("\n")
}
```
```

The key here to make it work is the following:

- `results='asis'`
- `print(p)`, after generating the output, you have to print it.
