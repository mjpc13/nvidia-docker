ARG ARCH=
ARG UBUNTU_VERSION= 
ARG CUDA_VERSION=
FROM ${ARCH}nvidia/cuda:${CUDA_VERSION}-base-${UBUNTU_VERSION}

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV ARCH_VAR=${ARCH}

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
    nano \
    julia

# Install Julia
#RUN \
  #add-apt-repository -y ppa:staticfloat/juliareleases && \
  #add-apt-repository -y ppa:staticfloat/julia-deps && \
  #apt-get update && \
  #apt-get install -y julia
  #rm -rf /var/lib/apt/lists/*


RUN if [ "$ARCH_VAR" = "linux/amd64" ]; \
    then wget https://julialang-s3.julialang.org/bin/linux/x64/1.7/julia-1.7.3-linux-x86_64.tar.gz\
    else wget https://julialang-s3.julialang.org/bin/linux/aarch64/1.7/julia-1.7.3-linux-aarch64.tar.gz\
    fi

RUN tar -xvzf *.tar.gz && mv julia-*/ /opt/

RUN ln -s /opt/julia-1.7.3/bin/julia /usr/local/bin/julia

# Install relevant Julia packages
RUN julia -e 'using Pkg; Pkg.add(["CUDA", "BenchmarkTools", "FileIO", "JLD2"])'

# Clean-up
RUN apt-get clean

CMD ["bash"]