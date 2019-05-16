#!/bin/bash

# To generate a genome file for U2OS 2-6-3 cell line where the transgene sequence is kept as a separate chromsome.
cat p3216PECMS2beta-1.fasta GRCh38.p7_complete_genome.fa > U2OS_2-6-3_hg38.fa

bowtie2-build -f U2OS_2-6-3_hg38.fa U2OS_263

for file in $(ls *_R1.fastq)

do

	echo "$file"
	f=${file%%_R1.fastq}
	echo "$f"


# To map to U2OS_263 genome which contains the transgene plasmid sequence as an additional chromosome with bowtie2
bowtie2 -q --phred33 --end-to-end --no-unal -p 10 -I 20 -X 1000 --fr --no-mixed --no-discordant -x U2OS_263 -1 "$f"_R1.fastq -2 "$f"_R2.fastq -S "$f"_U2OS-263.sam

# To convert .sam file to .bam file
samtools view -bS -o "$f"_U2OS-263.bam "$f"_U2OS-263.sam

# To sort the .bam file
samtools sort -@ 10 -o "$f"_U2OS-263.sorted.bam "$f"_U2OS-263.bam

# To index the .bam file
samtools index "$f"_U2OS-263.sorted.bam

# Remove the .sam file and the unsorted .bam file to save space
rm "$f"_U2OS-263.sam
rm "$f"_U2OS-263.bam

# Create bigwig files for easier visualization in IGV:
# Usage: bamCoverage -b reads.bam -o coverage.bw -of bigwig -bs 200 -p 10 --normalizeUsingRPKM --smoothLength 1000
bamCoverage -b "$f"_U2OS-263.sorted.bam -o "$f"_U2OS-263.sorted.bw -of bigwig -bs 200 -p 10 --normalizeUsingRPKM --smoothLength 1000

# Visualize the .bam files in IGV

done


# To get regions of enrichment compared to no_xlink pull-down sample
# Usage:  bamCompare -b1 treatment.bam -b2 control.bam -o log2ratio.bw
bamCompare -bs 1000 -p 10 --normalizeUsingRPKM --centerReads -b1 10601_8440_93794_H35MYBGXB_AO_2P_TAAGGCGA_U2OS-263.sorted.bam -b2 10601_8440_93796_H35MYBGXB_AO_30K_AGGCAGAA_U2OS-263.sorted.bam -o 2P_over_NoXlink_log2ratio.bw
bamCompare -bs 1000 -p 10 --normalizeUsingRPKM --centerReads -b1 10601_8440_93795_H35MYBGXB_AO_UV_CGTACTAG_U2OS-263.sorted.bam -b2 10601_8440_93796_H35MYBGXB_AO_30K_AGGCAGAA_U2OS-263.sorted.bam -o UV_over_NoXlink_log2ratio.bw
bamCompare -bs 1000 -p 10 --normalizeUsingRPKM --centerReads -b1 10601_8440_93794_H35MYBGXB_AO_2P_TAAGGCGA_U2OS-263.sorted.bam -b2 10601_8440_93795_H35MYBGXB_AO_UV_CGTACTAG_U2OS-263.sorted.bam -o 2P_over_UV_log2ratio.bw

transgene_2P= `samtools view 10601_8440_93794_H35MYBGXB_AO_2P_TAAGGCGA_U2OS-263.sorted.bam | grep -e p3216PECMS2beta-1 | wc -l | cut -d' ' -f1`
a=`samtools view 10601_8440_93794_H35MYBGXB_AO_2P_TAAGGCGA_U2OS-263.sorted.bam | wc -l | cut -d' ' -f1`
genomic_2P=$a-$transgene_2P
transgene_UV= `samtools view 10601_8440_93794_H35MYBGXB_AO_UV_TAAGGCGA_U2OS-263.sorted.bam | grep -e p3216PECMS2beta-1 | wc -l | cut -d' ' -f1`
b=`samtools view 10601_8440_93794_H35MYBGXB_AO_UV_TAAGGCGA_U2OS-263.sorted.bam | wc -l | cut -d' ' -f1`
genomic_UV=$b-$transgene_UV


enrichment= ($transgene_2P/$genomic_2P)/($transgene_UV/$genomic_UV)
echo The transgene is enriched $enrichment-fold over the genomic reads... 


