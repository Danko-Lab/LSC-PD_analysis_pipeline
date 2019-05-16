# LSC-PD_analysis_pipeline
Pipeline for locus-specific xlinking pull-down analysis

xxx.

## Citation

If you use this code or the resulting assemblies, please cite the following paper:

Judhajeet Ray, Paul R. Munn, Anniina Vihervaara, Abdullah Ozer, Charles G. Danko, John T. Lis (2018). *Chromatin conformation remains stable upon extensive transcriptional changes driven by heat shock.* bioRxiv: [https://www.biorxiv.org/content/10.1101/527838v1](https://www.biorxiv.org/content/10.1101/527838v1)
<publication.> <date.>; <vol.> <pages.>. doi: <link.>

## Prerequisites

* `Bash >= 4`

## Installation

There is no need for installation

## Program usage

This code takes as input xxx.

Program usage:

```
python gene_class_compartment_strength_boxplots.py \
-a <input file for HS HSF-dependent genes> \
-b <input file for NHS HSF-dependent genes> \
-c <input file for HS HSF-independent genes> \
-d <input file for NHS HSF-independent genes> \
-e <input file for HS down regulated genes> \
-f <input file for NHS down regulated genes> \
-g <input file for HS unregulated genes> \
-i <input file for NHS unregulated genes> \
-j <input file for HS silent genes> \
-k <input file for NHS silent genes> \
-o <output file prefix> -l <plot title> -t -h
```

Input parameters:

* Input files: Files containing a single column of numbers representing compartment strengths for each bin along the chromatin for each gene class
* Output file: File name prefix for plot (see output files below)
* -l: Plot title
* -t: Testing flag
* -h: Show usage help

Example:

```
python gene_class_compartment_strength_boxplots.py \
-a data/K562_HS_combined_KRnorm_all_50K_eigen_HSF-dependent_all_genes.txt \
-b data/K562_NHS_combined_KRnorm_all_50K_eigen_HSF-dependent_all_genes.txt \
-c data/K562_HS_combined_KRnorm_all_50K_eigen_HSF-independent_all_genes.txt \
-d data/K562_NHS_combined_KRnorm_all_50K_eigen_HSF-independent_all_genes.txt \
-e data/K562_HS_combined_KRnorm_all_50K_eigen_down_reg.txt \
-f data/K562_NHS_combined_KRnorm_all_50K_eigen_down_reg.txt \
-g data/K562_HS_combined_KRnorm_all_50K_eigen_unreg.txt \
-i data/K562_NHS_combined_KRnorm_all_50K_eigen_unreg.txt \
-j data/K562_HS_combined_KRnorm_all_50K_eigen_silent.txt \
-k data/K562_NHS_combined_KRnorm_all_50K_eigen_silent.txt \
-o output/K562_HS_NHS_gene_class_all_50K_boxplot \
-l 'Comparison of Gene Classes in K562 Cells' \
-t
```


Output files:

The program produces xxx.


