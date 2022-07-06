ARG ARCH=
ARG UBUNTU_VERSION= 
ARG CUDA_VERSION=
FROM ${ARCH}nvidia/cuda:${CUDA_VERSION}-devel-${UBUNTU_VERSION}

LABEL maintainer="Mario Cristovao <mjpc13@protonmail.com>"

#ENV ROS_PYTHON_VERSION=3
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

# Install Nsight System
RUN if [ "$UBUNTU_VERSION" = "ubuntu18.04" ]; \
    then curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/nsight-systems-2022.1.3_2022.1.3.3-1_amd64.deb --output nsight-systems.deb; \
    elif [ "$UBUNTU_VERSION" = "ubuntu20.04" ]; \
    then curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/nsight-systems-2022.1.3_2022.1.3.3-1_amd64.deb --output nsight-systems.deb; \
    else curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/nsight-systems-2022.1.3_2022.1.3.3-1_amd64.deb --output nsight-systems.deb; \
    fi
RUN apt install -y ./nsight-systems.deb

# Clean-up
RUN apt-get clean && rm -rf nsight-systems.deb

CMD ["bash"]
