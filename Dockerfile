# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set non-interactive installation to avoid getting stuck at prompts
ARG DEBIAN_FRONTEND=noninteractive

# Add essential environment variables
ENV PATH="/opt/STAR-2.7.11b/bin/Linux_x86_64_static:/opt/hisat2:/opt/bowtie2:/opt/samtools-1.10:/usr/local/bin:/opt/FastQC:$PATH"

# Install system dependencies and tools
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    gcc \
    g++ \
    make \
    zlib1g-dev \
    build-essential \
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    ca-certificates \
    default-jre \
    unzip \
    python3 \
    python3-pip \
    git \
    tar \
    xz-utils \
    vim-common \
    cutadapt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Quality Control Tools
## FastQC
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip && \
    unzip fastqc_v0.12.1.zip && \
    chmod +x FastQC/fastqc && \
    mv FastQC /opt/ && \
    ln -s /opt/FastQC/fastqc /usr/local/bin/fastqc && \
    rm fastqc_v0.12.1.zip

## MultiQC
RUN pip3 install multiqc

# Read Trimming and Filtering Tools
## Trimmomatic
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip && \
    unzip Trimmomatic-0.39.zip -d /opt/ && \
    mv /opt/Trimmomatic-0.39/trimmomatic-0.39.jar /opt/trimmomatic.jar && \
    ln -sf /opt/trimmomatic.jar /usr/local/bin/trimmomatic && \
    rm Trimmomatic-0.39.zip

## FASTX-Toolkit
RUN wget http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 && \
    tar -xjf fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 -C /opt/ && \
    ln -sf /opt/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64/* /usr/local/bin/ && \
    rm fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2

# Alignment Tools
## STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.7.11b.tar.gz && \
    tar -xzf 2.7.11b.tar.gz && \
    rm 2.7.11b.tar.gz && \
    mkdir -p /opt/STAR-2.7.11b/bin/Linux_x86_64_static && \
    cd STAR-2.7.11b/source && \
    make STAR && \
    mv STAR /opt/STAR-2.7.11b/bin/Linux_x86_64_static

## Bowtie2
RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.2/bowtie2-2.4.2-linux-x86_64.zip && \
    unzip bowtie2-2.4.2-linux-x86_64.zip && \
    mv bowtie2-2.4.2-linux-x86_64 /opt/bowtie2 && \
    ln -sf /opt/bowtie2/* /usr/local/bin/ && \
    rm bowtie2-2.4.2-linux-x86_64.zip

## HISAT2
RUN git clone https://github.com/DaehwanKimLab/hisat2.git /opt/hisat2 && \
    cd /opt/hisat2 && \
    make && \
    ln -sf /opt/hisat2/* /usr/local/bin/

# Post Alignment Tools
## SAMtools
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
    tar -xjf samtools-1.10.tar.bz2 -C /opt/ && \
    cd /opt/samtools-1.10 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm /samtools-1.10.tar.bz2

## PICARD
RUN wget https://github.com/broadinstitute/picard/releases/download/2.23.9/picard.jar -O /opt/picard.jar && \
    ln -sf /opt/picard.jar /usr/local/bin/picard

# Create a non-root user
RUN groupadd -r appgroup && useradd -r -g appgroup appuser && mkdir -p /home/appuser && chown -R appuser:appgroup /home/appuser

# Switch to the non-root user
USER appuser

# Set the default command to run when starting the container
CMD ["bash"]
