---
title: Understand the output from cellranger
date: 2024-02-12
categories: [Bioinformatics, scRNA-Seq]
tags: [cellranger]     # TAG names should always be lowercase
published: true
---

Cell Ranger is a popular software package developed by 10x Genomics for analyzing single-cell RNA sequencing (scRNA-seq) data. When you run `cellranger count`, it generates several output files and folders that contain processed data, analysis results, and quality control metrics. Here's an overview of the main files and folders generated by `cellranger count`:

1. **`outs/` folder**:
   - This is the main output folder where most of the analysis results are stored.
   - It contains subfolders such as `filtered_feature_bc_matrix/`, `raw_feature_bc_matrix/`, `analysis/`, etc.

2. **`outs/raw_feature_bc_matrix/` folder**:
   - Contains the raw feature-barcode matrix (matrix of gene expression counts).
   - Each row corresponds to a gene, and each column corresponds to a cell barcode.
   - This matrix includes all detected genes and their counts for each cell barcode before any filtering or normalization.

3. **`outs/filtered_feature_bc_matrix/` folder**:
   - Contains the filtered feature-barcode matrix.
   - This matrix typically represents the filtered and normalized gene expression data after quality control and filtering steps.
   - Each row corresponds to a gene, and each column corresponds to a cell barcode.

4. **`outs/analysis/` folder**:
   - Contains various analysis outputs, including clustering results, dimensionality reduction plots, and other analysis artifacts.
   - For example, you might find files related to t-SNE plots, UMAP plots, Louvain clustering results, etc.

5. **`outs/metrics_summary.csv` file**:
   - Contains summary metrics for quality control and analysis.
   - This CSV file typically includes metrics such as the number of reads, number of cells detected, median genes per cell, etc.

6. **`outs/web_summary.html` file**:
   - Provides an interactive HTML summary of the analysis results.
   - This file can be viewed in a web browser and contains various plots and statistics summarizing the analysis.

7. **`outs/possorted_genome_bam.bam` file**:
   - Contains the aligned reads in BAM format.
   - This file includes information about the alignment of reads to the reference genome.

8. **`outs/possorted_genome_bam.bam.bai` file**:
   - Index file for the sorted BAM file.
   - It allows for efficient querying and retrieval of reads from the BAM file.

These are some of the main files and folders generated by `cellranger count`. The specific contents and structure may vary depending on the version of Cell Ranger and the parameters used during the analysis.

## What can we do after this step?

Once you have processed scRNA-seq data using Cell Ranger and obtained the output files, there are several potential follow-up analyses and programs you can use to further explore and analyze the data. Some of the common analyses and tools include:

1. **Quality Control (QC) and Data Exploration**:
   - Tools: Seurat, Scanpy, scater
   - Analyses: QC metrics visualization, dimensionality reduction (PCA, t-SNE, UMAP), batch effect correction, visualization of gene expression patterns.

2. **Clustering and Cell Type Identification**:
   - Tools: Seurat, Scanpy, scran
   - Analyses: Cell clustering, identification of cell types and states, marker gene identification, cell type annotation.

3. **Differential Expression Analysis**:
   - Tools: Seurat, Scanpy, edgeR, DESeq2
   - Analyses: Identification of differentially expressed genes between cell types or conditions, gene set enrichment analysis.

4. **Trajectory Inference and Pseudotime Analysis**:
   - Tools: Monocle, Scanpy, Slingshot, destiny
   - Analyses: Reconstruction of developmental trajectories, identification of intermediate cell states, inference of pseudotime.

5. **Spatial Analysis**:
   - Tools: Seurat, SpatialDE, STViewer
   - Analyses: Spatial mapping of gene expression, identification of spatially associated cell types, visualization of spatial patterns.

6. **Integration with Other Omics Data**:
   - Tools: Seurat, Scanpy, scMerge
   - Analyses: Integration of scRNA-seq data with other omics data (e.g., scATAC-seq, spatial transcriptomics), multi-omics analysis.

7. **Functional Annotation and Pathway Analysis**:
   - Tools: clusterProfiler, EnrichR, gProfiler
   - Analyses: Functional enrichment analysis, pathway analysis, identification of enriched biological processes and pathways.

8. **Single-Cell Genomic Data Visualization**:
   - Tools: Loupe Cell Browser, CellBrowser, Cellxgene
   - Analyses: Interactive visualization of single-cell data, exploration of gene expression patterns, cell type distributions, and spatial relationships.

These are just a few examples of the many analyses and tools available for exploring and analyzing scRNA-seq data. The choice of analysis will depend on the specific research questions, experimental design, and characteristics of the dataset. It's common to use a combination of different tools and analyses to gain comprehensive insights into single-cell transcriptomic data.
