---
title: How to normalize read counts for RNA-Seq?
date: 2024-02-26
categories: [Bioinformatics, RNA-Seq]
tags: [normalization]  # TAG names should always be lowercase
published: true
---

Various NGS technologies are able to profile gene expression, but how to make them comparable is another question. There are two levels of comparability:

- Within-sample comparability (across genes within a sample)
- Across-samples comparability

Isolated RNA is converted to cDNA, a stable molecule, which can then be amplified and sequenced. Sequencing reads are then aligned to the genome assembly (sequence only) to identify their locations based on nucleotide matches. Mapping the reads to a gene annotation list will generate the number of sequencing reads that have aligned with a particular gene and are called counts. These counts at any particular gene are representative of the amount of gene expression in the sample and can be compared across horses to identify differentially expressed genes.

But the story doesn't end here, because there are biases due to multiple factors, such as:

- Transcript-length bias: If transcript A is 5 times longer than transcript B, it is likely that transcript A will have more reads than transcript B by chance, but it doesn't mean that the expression level of transcript A is higher than transcript B.
- Sequencing-depth bias: The sequencing depth among the samples might also be various. If sample A has more reads than sample B, this will also issue in a higher read count in sample A.

Therefore, there is a need to "normalized" the read counts. Here are some common methods to achieve this. Below is a quote from the paper from Zhao, Y. et al. (see reference at the end).

## RPKM and FPKM

> The measure RPKM (reads per kilobase of exon per million reads mapped) was devised as a within-sample normalization method; as such, it is suitable to compare gene expression levels within a single sample, rescaled to correct for both library size and gene length.
FPKM stands for fragments per kilobase of exon per million mapped fragments. It is analogous to RPKM and is used specifically in paired-end RNA-seq experiments.

## TPM

> TPM was introduced in an attempt to facilitate comparisons across samples. TPM stands for transcript per million, and the sum of all TPM values is the same in all samples, such that a TPM value represents a relative expression level that, in principle, should be comparable between samples.

## Count normalization methods

> The R package tximport was used to prepare gene level count data from RSEM output files. Subsequently, normalized count data were derived using the DESeq2 package. The normalization approach used by DESeq2 is to form a “virtual reference sample” by taking the geometric mean of counts over all samples for each gene. Then, DESeq2 normalizes each sample to this virtual reference to get one scaling factor per sample.

Please refer to [this table](https://hbctraining.github.io/Training-modules/planning_successful_rnaseq/lessons/sample_level_QC.html#common-normalization-methods) for a more expanded comparison from [Harvard Chan Bioinformatics Core](https://hbctraining.github.io/Training-modules/planning_successful_rnaseq/lessons/sample_level_QC.html).

## Reference

- Zhao, Y., Li, MC., Konaté, M.M. et al. TPM, FPKM, or Normalized Counts? A Comparative Study of Quantification Measures for the Analysis of RNA-seq Data from the NCI Patient-Derived Models Repository. J Transl Med 19, 269 (2021). [https://doi.org/10.1186/s12967-021-02936-w](https://doi.org/10.1186/s12967-021-02936-w)
- [How do I explain the difference between edgeR, LIMMA, DESeq etc. to experimental Biologist/non-bioinformatician](https://www.biostars.org/p/284775/)
- [Can someone please explain in simple terms how DESeq2 works?](https://www.biostars.org/p/127756/)
- [Differential gene expression (DGE) analysis](https://hbctraining.github.io/Training-modules/planning_successful_rnaseq/lessons/sample_level_QC.html)
