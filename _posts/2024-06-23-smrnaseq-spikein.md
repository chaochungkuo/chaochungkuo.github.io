---
title: Add spike-in sequences to nfcore/smrnaseq pipeline
date: 2024-06-23
categories: [Bioinformatics, pipeline]
tags: [nfcore, smrnaseq, spike-in]  # TAG names should always be lowercase
published: true
---

The current [nfcore/smrnaseq](https://nf-co.re/smrnaseq/2.3.0) pipeline (2.3.0)does not support spike-in sequences. However, it is possible to add spike-in sequences to the pipeline by following the steps below:

## Download the spike-in sequences

Download the handbook for [QIAseq miRNA Library QC PCR Handbook](https://www.qiagen.com/us/resources/download.aspx?id=8f2523cc-3af8-4cbf-bdd7-b8f538462755&lang=en) and find *Appendix C: QIAseq miRNA Library QC Spike- In Sequences*. Process the table and you can get the spike-in sequences as this file: [QIAseq_miRNA_Spikein.fa](https://github.com/chaochungkuo/chaochungkuo.github.io/blob/main/_posts/_files/QIAseq_miRNA_Spikein.fa).

## Add spike-in sequences to the hairpin and mature fasta files

You can download the latest fasta files from [mirbase](https://www.mirbase.org/download/) and add the spike-in sequences to the hairpin and mature fasta files. In order to make the quantification of the pipeline work, you need to modify the sequence names of the spike-in sequences to the organism you desire to quantify. Here is an example:

```
>UniSP112
GGTTCGTACGTACACTGTTCA
>UniSP110
TTCGAGGCCTATTAAACCTCTG
>UniSP136
ATCAGTTTCTTGTTCGTTTCA
>UniSP109
CGAAACTGGTGTCGACCGACA
```

Add 'hsa' for human:
```
>hsa-mir-UniSP112
GGTTCGTACGTACACTGTTCA
>hsa-mir-UniSP110
TTCGAGGCCTATTAAACCTCTG
>hsa-mir-UniSP136
ATCAGTTTCTTGTTCGTTTCA
>hsa-mir-UniSP109
CGAAACTGGTGTCGACCGACA
```

Then append these sequences to both the hairpin and mature fasta files.

## Modify the gff3 file

Download the latest gff3 file from [mirbase](https://www.mirbase.org/ftp.shtml) and add the following line to the end of the file:

```
hsa-mir-UniSP100    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP100;Alias=hsa-mir-UniSP100;Name=hsa-mir-UniSP100
hsa-mir-UniSP101    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP101;Alias=hsa-mir-UniSP101;Name=hsa-mir-UniSP101
hsa-mir-UniSP102    .   miRNA   1   20  .   +   .   ID=hsa-mir-UniSP102;Alias=hsa-mir-UniSP102;Name=hsa-mir-UniSP102
hsa-mir-UniSP103    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP103;Alias=hsa-mir-UniSP103;Name=hsa-mir-UniSP103
hsa-mir-UniSP104    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP104;Alias=hsa-mir-UniSP104;Name=hsa-mir-UniSP104
hsa-mir-UniSP105    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP105;Alias=hsa-mir-UniSP105;Name=hsa-mir-UniSP105
hsa-mir-UniSP106    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP106;Alias=hsa-mir-UniSP106;Name=hsa-mir-UniSP106
hsa-mir-UniSP107    .   miRNA   1   20  .   +   .   ID=hsa-mir-UniSP107;Alias=hsa-mir-UniSP107;Name=hsa-mir-UniSP107
hsa-mir-UniSP108    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP108;Alias=hsa-mir-UniSP108;Name=hsa-mir-UniSP108
hsa-mir-UniSP109    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP109;Alias=hsa-mir-UniSP109;Name=hsa-mir-UniSP109
hsa-mir-UniSP110    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP110;Alias=hsa-mir-UniSP110;Name=hsa-mir-UniSP110
hsa-mir-UniSP111    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP111;Alias=hsa-mir-UniSP111;Name=hsa-mir-UniSP111
hsa-mir-UniSP112    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP112;Alias=hsa-mir-UniSP112;Name=hsa-mir-UniSP112
hsa-mir-UniSP113    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP113;Alias=hsa-mir-UniSP113;Name=hsa-mir-UniSP113
hsa-mir-UniSP114    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP114;Alias=hsa-mir-UniSP114;Name=hsa-mir-UniSP114
hsa-mir-UniSP115    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP115;Alias=hsa-mir-UniSP115;Name=hsa-mir-UniSP115
hsa-mir-UniSP116    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP116;Alias=hsa-mir-UniSP116;Name=hsa-mir-UniSP116
hsa-mir-UniSP117    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP117;Alias=hsa-mir-UniSP117;Name=hsa-mir-UniSP117
hsa-mir-UniSP118    .   miRNA   1   20  .   +   .   ID=hsa-mir-UniSP118;Alias=hsa-mir-UniSP118;Name=hsa-mir-UniSP118
hsa-mir-UniSP119    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP119;Alias=hsa-mir-UniSP119;Name=hsa-mir-UniSP119
hsa-mir-UniSP120    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP120;Alias=hsa-mir-UniSP120;Name=hsa-mir-UniSP120
hsa-mir-UniSP121    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP121;Alias=hsa-mir-UniSP121;Name=hsa-mir-UniSP121
hsa-mir-UniSP122    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP122;Alias=hsa-mir-UniSP122;Name=hsa-mir-UniSP122
hsa-mir-UniSP123    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP123;Alias=hsa-mir-UniSP123;Name=hsa-mir-UniSP123
hsa-mir-UniSP124    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP124;Alias=hsa-mir-UniSP124;Name=hsa-mir-UniSP124
hsa-mir-UniSP125    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP125;Alias=hsa-mir-UniSP125;Name=hsa-mir-UniSP125
hsa-mir-UniSP126    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP126;Alias=hsa-mir-UniSP126;Name=hsa-mir-UniSP126
hsa-mir-UniSP127    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP127;Alias=hsa-mir-UniSP127;Name=hsa-mir-UniSP127
hsa-mir-UniSP128    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP128;Alias=hsa-mir-UniSP128;Name=hsa-mir-UniSP128
hsa-mir-UniSP129    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP129;Alias=hsa-mir-UniSP129;Name=hsa-mir-UniSP129
hsa-mir-UniSP130    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP130;Alias=hsa-mir-UniSP130;Name=hsa-mir-UniSP130
hsa-mir-UniSP131    .   miRNA   1   24  .   +   .   ID=hsa-mir-UniSP131;Alias=hsa-mir-UniSP131;Name=hsa-mir-UniSP131
hsa-mir-UniSP132    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP132;Alias=hsa-mir-UniSP132;Name=hsa-mir-UniSP132
hsa-mir-UniSP133    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP133;Alias=hsa-mir-UniSP133;Name=hsa-mir-UniSP133
hsa-mir-UniSP134    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP134;Alias=hsa-mir-UniSP134;Name=hsa-mir-UniSP134
hsa-mir-UniSP135    .   miRNA   1   24  .   +   .   ID=hsa-mir-UniSP135;Alias=hsa-mir-UniSP135;Name=hsa-mir-UniSP135
hsa-mir-UniSP136    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP136;Alias=hsa-mir-UniSP136;Name=hsa-mir-UniSP136
hsa-mir-UniSP137    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP137;Alias=hsa-mir-UniSP137;Name=hsa-mir-UniSP137
hsa-mir-UniSP138    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP138;Alias=hsa-mir-UniSP138;Name=hsa-mir-UniSP138
hsa-mir-UniSP139    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP139;Alias=hsa-mir-UniSP139;Name=hsa-mir-UniSP139
hsa-mir-UniSP140    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP140;Alias=hsa-mir-UniSP140;Name=hsa-mir-UniSP140
hsa-mir-UniSP141    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP141;Alias=hsa-mir-UniSP141;Name=hsa-mir-UniSP141
hsa-mir-UniSP142    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP142;Alias=hsa-mir-UniSP142;Name=hsa-mir-UniSP142
hsa-mir-UniSP143    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP143;Alias=hsa-mir-UniSP143;Name=hsa-mir-UniSP143
hsa-mir-UniSP144    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP144;Alias=hsa-mir-UniSP144;Name=hsa-mir-UniSP144
hsa-mir-UniSP145    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP145;Alias=hsa-mir-UniSP145;Name=hsa-mir-UniSP145
hsa-mir-UniSP146    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP146;Alias=hsa-mir-UniSP146;Name=hsa-mir-UniSP146
hsa-mir-UniSP147    .   miRNA   1   22  .   +   .   ID=hsa-mir-UniSP147;Alias=hsa-mir-UniSP147;Name=hsa-mir-UniSP147
hsa-mir-UniSP148    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP148;Alias=hsa-mir-UniSP148;Name=hsa-mir-UniSP148
hsa-mir-UniSP149    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP149;Alias=hsa-mir-UniSP149;Name=hsa-mir-UniSP149
hsa-mir-UniSP150    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP150;Alias=hsa-mir-UniSP150;Name=hsa-mir-UniSP150
hsa-mir-UniSP151    .   miRNA   1   21  .   +   .   ID=hsa-mir-UniSP151;Alias=hsa-mir-UniSP151;Name=hsa-mir-UniSP151
```

## Add the parameters to nfcore/smrnaseq


And then modify your command for running the pipeline:

```bash
nextflow run nf-core/smrnaseq -r 2.3.0 \
     -profile docker \
     --input samplesheet.csv \
     --genome 'hg38' \
     --mirtrace_species 'hsa' \
     --mirna_gtf hsa_modified.gff3 \
     --mature mature_with_qiaseq_spikein.fa \
     --hairpin hairpin_with_qiaseq_spikein.fa \
     --protocol 'qiaseq' \
     --outdir results \
     --save_reference \
     --with_umi \
     --umitools_extract_method regex \
     --umitools_bc_pattern '.+(?P<discard_1>AACTGTAGGCACCATCAAT){s<=2}(?P<umi_1>.{12})(?P<discard_2>.*)' # Regex pattern for Qiagen_QIAseq_miRNA
```

Then the spike-in sequences will be quantified together with the other miRNAs.

## Reference

* Discuss on Slack channel: [https://nfcore.slack.com/archives/CL66GAJBF/p1678195598260819](https://nfcore.slack.com/archives/CL66GAJBF/p1678195598260819)
