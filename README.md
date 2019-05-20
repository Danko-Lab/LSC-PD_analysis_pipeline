# LSC-PD_analysis_pipeline
Pipeline for locus-specific xlinking pull-down analysis

This shell script is designed to analyze the sequencing data from a locus-specific crosslinking and pull-down experiment.

Program takes a transgene sequence (in fasta format) and species genome sequence (in fasta format) and generates a combined genome and index.
Then the paired and sequencing reads (in *_R1.fastq and *_R2.fastq files) are aligned to the combined genome.

A bigwig (.bw) file is generated for the alignments for easy visualization in genome browsers.

Comparative bigwig files are generated between samples and controls (in our case 2-photon crosslinked sample (2P) is compared against negative controls (whole cell UV crosslinking (UV) and no UV crosslinking).

Finally, the script should report fold-enrichment value: calculated from reads mapping to the transgene over the rest of the genome in 2P samples compared to UV or no-Xlinking samples.


## Prerequisites

* `Bash >= 4`

## Installation

There is no need for installation (the script is executed from the terminal's command line).
