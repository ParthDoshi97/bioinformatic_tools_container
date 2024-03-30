# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set noninteractive installation to avoid getting stuck at prompts
ARG DEBIAN_FRONTEND=noninteractive

# Install necessary libraries and tools
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    gcc \
    g++ \
    make \
    zlib1g-dev \
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    ca-certificates \
    default-jre  \
    unzip 

# Install bioinformatics tools. 
# SAMtools:
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
    tar -xjf samtools-1.10.tar.bz2 && \
    cd samtools-1.10 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# Fastqc:
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip && \
    unzip fastqc_v0.12.1.zip && \
    chmod +x FastQC/fastqc && \
    mv FastQC /opt/
    
# Add FastQC to PATH
ENV PATH="/opt/FastQC:$PATH"

# Set the default command to run when starting the container
CMD ["bash"]




