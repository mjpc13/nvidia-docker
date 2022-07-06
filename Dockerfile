ARG ARCH=
ARG UBUNTU_VERSION= 
ARG CUDA_VERSION=
FROM ${ARCH}nvidia/cuda:${CUDA_VERSION}-devel-${UBUNTU_VERSION}

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

# Dependencies for glvnd and X11.
RUN apt-get update \
  && apt-get install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6 \
  && rm -rf /var/lib/apt/lists/*# Env vars for the nvidia-container-runtime.
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute

# Install Nsight System
RUN apt-get install -y qt5-default cuda-nsight-systems-11-7

# Clean-up
RUN apt-get clean

CMD ["bash"]
