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
    build-essential \
    libncurses5-dev \
    libbz2-dev \
    liblzma-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    ca-certificates \
    default-jre  \
    unzip   \
    python3 \
    python3-pip \
    cutadapt

##=============== Install bioinformatics tools. ================##

## Quality control ##
# Fastqc:
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip && \
    unzip fastqc_v0.12.1.zip && \
    chmod +x FastQC/fastqc && \
    mv FastQC /opt/
    
# Add FastQC to PATH
ENV PATH="/opt/FastQC:$PATH"

# Multqc
RUN pip3 install multiqc

## Read Trimming And Filtering ##

# Trimmomatic 
RUN wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.39.zip && \
    unzip Trimmomatic-0.39.zip -d /opt/ && \
    mv /opt/Trimmomatic-0.39/trimmomatic-0.39.jar /opt/trimmomatic.jar

# FASTX-Toolkit
RUN wget http://hannonlab.cshl.edu/fastx_toolkit/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 && \
    tar -xjf fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64.tar.bz2 -C /opt/ && \
    ln -s /opt/fastx_toolkit_0.0.13_binaries_Linux_2.6_amd64/* /usr/local/bin/
    
## Alignment tools ##

# STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.7.11b.tar.gz && \
    tar -xzf 2.7.11b.tar.gz && \
    rm 2.7.11b.tar.gz && \
    cd STAR-2.7.11b/source && \
    make STAR
    
# Bowtie2 
RUN wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.2/bowtie2-2.4.2-linux-x86_64.zip && \
    unzip bowtie2-2.4.2-linux-x86_64.zip && \
    mv bowtie2-2.4.2-linux-x86_64 /opt/bowtie2 && \
    ln -s /opt/bowtie2/bowtie2 /usr/local/bin/bowtie2

# Hista2
RUN git clone https://github.com/DaehwanKimLab/hisat2.git && \
   cd hisat2 && \
   make

# Post Alignment tools
# SAMtools
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2 && \
    tar -xjf samtools-1.10.tar.bz2 && \
    cd samtools-1.10 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# PICARD
# Set the default command to run when starting the container
CMD ["bash"]




