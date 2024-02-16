---
title: An idea for building blocks of many tools -- Genomkit
date: 2024-02-07
categories: [Bioinformatics, development]
tags: [genomkit]     # TAG names should always be lowercase
---

Through the development of bioinformatic research, there are more and more specific tools developed for particular tasks. However, it is not a trivial task to master all the tools in order to integrate all the file types or dimensions of a biological system. I feel that there is a crucial need to bridge all the gaps and make the integration work approachable to most bioinformaticians.

There are various file types in bioinformatics, such as FASTQ for reads, FASTA for sequences, BAM for alignments, BigWig for coverage, BED for regions, GTF/GTT for annotation, ... etc. Each file type represent an unique type of genomic information. However, it is also limited in its own boundary.

Therefore, I want to develop a package called GenomKit which represents a kit of basic tools for all bioinformatic file types. As a kit, it aims to include everything you need for performing an advanced analysis. GenomKit is supposed to serve as legos for you to build whatever you want to achieve.

For example, if you want to build a peak caller for differential peak calling, you need the modules to load BAM files, calculate coverage, and export BED or BigWig files. What you need to do is to focus on the core algorithm for calling the peaks.

Another example is to make a deep learning tool on genomic sequences. You might have an idea to retrieve certain genomic sequences and tokenize them to feed your model. GenomKit can handle GTF, BED and FASTA for feeding the appropriate data for your model.

Take a look here:
[https://github.com/chaochungkuo/Genomkit](https://github.com/chaochungkuo/Genomkit)

I want to finish this in 2024. Finger crossed.
