ARG ARCH=
ARG UBUNTU_VERSION= 
ARG CUDA_VERSION=
FROM ${ARCH}nvidia/cuda:${CUDA_VERSION}-base-${UBUNTU_VERSION}

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

#ENV ROS_PYTHON_VERSION=3
ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash","-c"]

# Install packages
RUN apt-get update \
    && apt-get install -y \
    # Basic utilities
    build-essential \
    apt-utils \
    curl \
    git \
    wget \
    vim \
    nano 

# Clean-up
RUN apt-get clean

CMD ["bash"]