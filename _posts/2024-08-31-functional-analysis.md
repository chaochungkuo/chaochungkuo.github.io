---
title: Introduction to Functional Analysis on Genomic Data with GSEApy
date: 2024-08-31
categories: [Bioinformatics, functional analysis]
tags: [gseapy, python, go]  # TAG names should always be lowercase
published: true
---

Functional analysis is a crucial step in understanding the biological significance of genes identified in genomic studies. Whether you're dealing with differentially expressed genes (DEGs) from RNA sequencing or other high-throughput data, functional analysis helps you interpret these genes in the context of biological pathways, processes, and functions. 

For new learners in bioinformatics, this article will introduce key methods in functional analysis—such as Gene Ontology (GO) analysis, Gene Set Enrichment Analysis (GSEA), and pathway analysis—and show you how to perform these analyses using a powerful and user-friendly Python package called **GSEApy**.

### **Functional Analysis: Why and How?**

Functional analysis allows you to move beyond lists of genes to understand their roles in broader biological contexts. Here’s a quick overview of the primary methods:

#### **1. Gene Ontology (GO) Analysis**
- **Purpose**: Categorizes genes into groups based on their associated biological processes, molecular functions, and cellular components.
- **Statistics**: Typically involves hypergeometric or Fisher’s exact tests to assess whether specific GO terms are overrepresented among your genes of interest.
- **Pros**:
  - Comprehensive coverage of biological functions.
  - Allows for hierarchical exploration of biological terms.
- **Cons**:
  - Can be redundant with similar terms showing up multiple times.
  - Biased towards well-studied genes.

#### **2. Gene Set Enrichment Analysis (GSEA)**
- **Purpose**: Determines if predefined sets of genes (such as those in a pathway) show statistically significant, concordant differences between two biological states.
- **Statistics**: Uses an enrichment score (ES) calculated from ranked gene lists, with significance assessed via permutation testing.
- **Pros**:
  - No need for arbitrary cutoffs to define significant genes.
  - Captures subtle, coordinated changes in pathways.
- **Cons**:
  - Computationally intensive.
  - Results depend on the quality of the gene ranking.

#### **3. Pathway Analysis**
- **Purpose**: Associates genes with known biological pathways to understand their roles within these established networks.
- **Statistics**: Often relies on over-representation analysis (ORA) or enrichment scores to determine pathway significance.
- **Pros**:
  - Provides context by linking genes to biological pathways.
  - Useful for identifying potential therapeutic targets.
- **Cons**:
  - Pathway databases can be incomplete or biased.
  - Pathways are generally static and may not reflect dynamic interactions.

| **Method**        | **Purpose**                                                   | **Statistics**                                                      | **Pros**                                                       | **Cons**                                                        |
|-------------------|---------------------------------------------------------------|---------------------------------------------------------------------|----------------------------------------------------------------|-----------------------------------------------------------------|
| **GO Analysis**   | Categorize genes into biological processes, functions, and components | Hypergeometric/Fisher’s exact test | Comprehensive, hierarchical structure                         | Redundant terms, biased towards well-studied genes              |
| **GSEA**          | Assess enrichment of predefined gene sets (pathways, etc.)    | Enrichment score (ES), permutation testing                          | No arbitrary cutoffs, pathway-level insights                   | Computationally intensive, depends on gene ranking quality      |
| **Pathway Analysis** | Associate genes with known biological pathways                | Over-representation analysis (ORA), enrichment scores                | Provides biological context, useful for drug discovery         | Incomplete or biased pathway databases, static nature of pathways |

### **Performing Functional Analysis with GSEApy**

GSEApy is a powerful Python library that allows you to perform all the above analyses in a simple and consistent way. Below, we'll walk through examples of how to use GSEApy for Gene Ontology (GO) analysis, Gene Set Enrichment Analysis (GSEA), and pathway analysis.

#### **1. Gene Ontology (GO) Analysis with GSEApy**

GO analysis helps categorize your gene list based on known biological functions. Here’s how you can perform GO enrichment analysis using GSEApy:

```python
import gseapy as gp

# Define your gene list (e.g., list of DEGs)
gene_list = ['BRCA1', 'TP53', 'EGFR', 'MTOR']

# Perform GO Biological Process enrichment analysis using Enrichr
go_results = gp.enrichr(
    gene_list=gene_list,                     # List of genes
    gene_sets=['GO_Biological_Process_2018'], # GO gene sets (you can also use GO_Molecular_Function, GO_Cellular_Component)
    organism='Human',                         # Specify the organism
    outdir='go_enrichment_results',           # Output directory
    cutoff=0.05                               # Adjusted p-value cutoff
)

# View the top results
print(go_results.results.head())

# Visualize the results
go_results.plot()
```

#### **2. Gene Set Enrichment Analysis (GSEA) with GSEApy**

GSEA is a robust method to identify whether a set of genes shows significant differences between two conditions. Here’s how to run GSEA using GSEApy:

```python
# Assuming you have a ranked gene list (e.g., a DataFrame or text file with gene names and ranking scores)
ranked_genes = "path_to_your_ranked_gene_list.txt"

# Perform GSEA
gsea_results = gp.gsea(
    data=ranked_genes,                # Path to ranked list or DataFrame
    gene_sets='KEGG_2016',            # Gene set database (e.g., KEGG, GO, etc.)
    outdir='gsea_results',            # Output directory for results
    permutation_num=100,              # Number of permutations
    min_size=15,                      # Min gene set size
    max_size=500,                     # Max gene set size
    seed=42,
    verbose=True,
)

# View the top results
print(gsea_results.res2d.head())

# Plot the results
gsea_results.plot()
```

#### **3. Pathway Analysis with GSEApy (KEGG Pathway Example)**

Pathway analysis is essential to understand how your genes of interest are involved in specific biological pathways. Here's how to perform pathway analysis using KEGG with GSEApy:

```python
# Perform KEGG pathway enrichment analysis using Enrichr
kegg_results = gp.enrichr(
    gene_list=gene_list,            # List of genes
    gene_sets='KEGG_2016',          # KEGG pathways database
    organism='Human',               # Specify the organism
    outdir='kegg_results',          # Output directory
    cutoff=0.05                     # Adjusted p-value cutoff
)

# View the top results
print(kegg_results.results.head())

# Visualize the results
kegg_results.plot()
```

### **Conclusion**

GSEApy is a versatile and powerful tool that allows bioinformaticians, even those new to the field, to perform a wide range of functional analyses, from GO enrichment to pathway analysis and GSEA. By understanding the strengths and limitations of each method, you can apply them more effectively to your own data, gaining deeper insights into the biological significance of your results.

Whether you're categorizing genes by their functions, identifying key pathways, or exploring broader gene sets, GSEApy provides an accessible and consistent platform for your analyses. With just a few lines of Python code, you can go from a list of genes to a detailed understanding of their roles in complex biological systems.
