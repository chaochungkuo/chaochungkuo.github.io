---
title: Statistics for NGS data
date: 2024-02-27
categories: [Bioinformatics, data]
tags: [shell]  # TAG names should always be lowercase
published: true
---

Sometimes the editors of the journal may ask for some statistics for the raw data. Here I just note some codes for them.

## Total number of sequenced reads

Execute this command in the directory where FASTQ files are:

```shell
for FASTQ in ./*.fastq.gz; do echo $FASTQ $($(zcat ${FASTQ}|wc -l)/4|bc); done
```

## Total number of uniquely mapped reads

Execute this command in the directory where FASTQ files are:

```shell
for BAM in ./*.bam; do echo $BAM; samtools view -c $BAM; done
```

## rRNA rate

Ratio of all reads aligned to rRNA regions to total uniquely mapped reads. We have to get rRNA coordinates from BioMart first. Here is the example for Hg38: 

```
chr1	146539541	146539663	RNA5SP536	0	-
chr1	228610268	228610386	RNA5S1	0	-
chr1	228612509	228612627	RNA5S2	0	-
chr1	228614750	228614868	RNA5S3	0	-
chr1	228616991	228617109	RNA5S4	0	-
chr1	228619232	228619350	RNA5S5	0	-
chr1	228621447	228621565	RNA5S6	0	-
chr1	228623667	228623785	RNA5S7	0	-
chr1	228625909	228626027	RNA5S8	0	-
chr1	228628148	228628266	RNA5S9	0	-
chr1	228630390	228630508	RNA5S10	0	-
chr1	228632631	228632749	RNA5S11	0	-
chr1	228634871	228634989	RNA5S12	0	-
chr1	228637096	228637214	RNA5S13	0	-
chr1	228639337	228639455	RNA5S14	0	-
chr1	228641568	228641686	RNA5S15	0	-
chr1	228643809	228643927	RNA5S16	0	-
chr1	228646040	228646158	RNA5S17	0	-
chr1	207708898	207708981	RNA5SP534	0	-
chr3	181822872	181822990	RNA5SP150	0	-
chr4	177457111	177457228	RNA5SP172	0	-
chr6	15522195	15522300	5S_rRNA	0	-
chr9	41237440	41237557	RNA5SP530	0	-
chr11	74198748	74198854	RNA5SP343	0	-
chr17	38144201	38144287	RNA5SP526	0	-
chr17	45327366	45327497	RNA5SP443	0	-
chr17	37940704	37940790	5S_rRNA	0	-
chr20	29741510	29741661	5_8S_rRNA	0	-
chr20	29297095	29297246	5_8S_rRNA	0	-
chr20	30816156	30816274	RNA5SP528	0	-
chr20	30484925	30485076	5_8S_rRNA	0	-
chr22	11249809	11249959	5_8S_rRNA	0	-
chr1	143439605	143439714	RNA5SP533	0	+
chr1	144265217	144265326	RNA5SP529	0	+
chr2	89600571	89600680	5S_rRNA	0	+
chr4	67439992	67440118	RNA5SP527	0	+
chr5	139012329	139012441	RNA5SP194	0	+
chr8	48316669	48316770	RNA5SP531	0	+
chr11	102057854	102057960	RNA5SP535	0	+
chr14	16057472	16057622	5_8S_rRNA	0	+
chr20	29874059	29874177	RNA5SP532	0	+
chr21	8256781	8256933	5_8S_rRNA	0	+
chr21	8395607	8395759	RNA5-8SN3	0	+
chr21	8439823	8439975	RNA5-8SN1	0	+
chr21	8212572	8212724	RNA5-8SN2	0	+
```

Then we can run the following script to count the mapped reads on those rRNA regions:

```shell
for BAM in *.sorted.bam; do
    filename=${BAM##*/}
    filename="$(basename $filename .sorted.bam)"
    echo $filename $(samtools view -c -L $rRNA_BED $BAM)
done
```

## Expression profile efficiency

Ratio of exon-mapped reads to total uniquely mapped reads. For this work, we have to get a BED file for all exon coordinates. I generated this from Gencode GTF file. Below is the code to compute it:

```shell
for BAM in *.sorted.bam; do
    filename=${BAM##*/}
    filename="$(basename $filename .sorted.bam)"
    echo $filename $(samtools view -c -L $exons_BED $BAM)
done
```
