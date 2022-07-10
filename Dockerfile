ARG ARCH=
ARG UBUNTU_VERSION= 
ARG CUDA_VERSION=
FROM ${ARCH}nvidia/cuda:${CUDA_VERSION}-base-${UBUNTU_VERSION}

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash","-c"]

# Install packages
RUN apt-get update \
    && apt-get install -y \
    # Basic utilities
    build-essential \
    software-properties-common \
    apt-utils \
    curl \
    git \
    wget \
    vim \
    nano 

# Install Julia
RUN \
  add-apt-repository -y ppa:staticfloat/juliareleases && \
  add-apt-repository -y ppa:staticfloat/julia-deps && \
  apt-get update && \
  apt-get install -y julia && \
  rm -rf /var/lib/apt/lists/*

# Install relevant Julia packages
RUN julia -e 'using Pkg; Pkg.add(["CUDA", "BenchmarkTools", "FileIO", "JLD2"])'

# Clean-up
RUN apt-get clean

CMD ["bash"]