
# Singularity Container for Bioinformatics Tools

## Overview

This Singularity container is designed to provide a comprehensive suite of bioinformatics tools for quality control, read trimming, alignment, and post-alignment analysis. The container is based on Ubuntu 20.04 and includes commonly used tools such as FastQC, MultiQC, Trimmomatic, STAR, Bowtie2, HISAT2, SAMtools, PICARD, HOMER, MACS2, and MEME Suite.

## Features

- **Quality Control Tools**
  - **FastQC**: A quality control tool for high throughput sequence data.
  - **MultiQC**: Aggregates results from bioinformatics analyses into a single report.

- **Read Trimming and Filtering Tools**
  - **Trimmomatic**: A flexible read trimming tool for Illumina NGS data.
  - **Fastx Toolkit**: A collection of command line tools for Short-Reads FASTA/FASTQ files preprocessing.

- **Alignment Tools**
  - **STAR**: A fast RNA-seq read mapper.
  - **Bowtie2**: A fast and sensitive gapped read aligner.
  - **HISAT2**: A fast and sensitive alignment program for mapping next-generation sequencing reads.

- **Post-Alignment Tools**
  - **SAMtools**: A suite of programs for interacting with high-throughput sequencing data.
  - **PICARD**: A set of command line tools for manipulating high-throughput sequencing data.
  - **HOMER**: A suite of tools for Motif Discovery and next-generation sequencing analysis.
  - **MACS2**: Model-based Analysis of ChIP-Seq data.
  - **MEME Suite**: A collection of tools for the discovery and analysis of sequence motifs.

## Installation

To build the Singularity container, use the following command:

```bash
sudo singularity build bioinformatics.sif Singularity.def
```

## Usage

To run the container, use:

```bash
singularity exec bioinformatics.sif <command>
```

For example, to run FastQC on a file:

```bash
singularity exec bioinformatics.sif fastqc sample.fastq
```

## Included Tools and Versions

- **Ubuntu**: 20.04
- **Perl**: 5.40.0
- **FastQC**: 0.12.1
- **MultiQC**: Latest via pip
- **Trimmomatic**: 0.39
- **Fastx Toolkit**: 0.0.13
- **STAR**: 2.7.11b
- **Bowtie2**: 2.4.2
- **HISAT2**: Latest from GitHub
- **SAMtools**: 1.10
- **PICARD**: 2.23.9
- **HOMER**: Latest via Perl script
- **MACS2**: Latest via pip
- **MEME Suite**: 5.5.5

## Environment Variables

The container sets the following environment variables:

```bash
export DEBIAN_FRONTEND=noninteractive
export PATH="/opt/STAR-2.7.11b/bin/Linux_x86_64_static:/opt/hisat2:/opt/bowtie2:/opt/samtools-1.10:/usr/local/bin:/opt/FastQC:$PATH"
export PATH="/root/homer/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/libexec/meme-5.5.5:$PATH"
```

## Author

Parth Doshi

## Version

1.0

## Help

This container includes tools for quality control, read trimming, alignment, and post-alignment analysis in bioinformatics.

## Labels

- **Author**: Parth Doshi
- **Version**: 1.0
```

This README provides a clear and concise overview of the container, its features, installation instructions, usage examples, included tools and versions, environment variables, and author information. Adjust the placeholders such as `YourName` and any other details as necessary.
