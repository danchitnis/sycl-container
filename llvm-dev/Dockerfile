FROM danchitnis/sycl-container:llvm-cuda

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && \
    apt-get install -y \
    sudo \
    wget \
    curl

RUN apt-get install -y build-essential python3-dev git cmake python3-pip software-properties-common


#Intel OpenCl
#https://software.intel.com/content/www/us/en/develop/documentation/installation-guide-for-intel-oneapi-toolkits-linux/top/installation/install-using-package-managers/apt.html
RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB -O - | sudo apt-key add - && \
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list && \
    sudo add-apt-repository "deb https://apt.repos.intel.com/oneapi all main" && \
    apt-get -y update

# https://software.intel.com/content/www/us/en/develop/articles/intel-cpu-runtime-for-opencl-applications-with-sycl-support.html
# https://oneapi-src.github.io/oneapi-ci/
RUN apt-get -y install intel-oneapi-runtime-opencl intel-oneapi-runtime-tbb


WORKDIR / 
#intel GPU
#https://github.com/intel/oneapi-containers/blob/master/images/docker/runtime-ubuntu18.04/Dockerfile
RUN echo 'deb [trusted=yes arch=amd64] https://repositories.intel.com/graphics/ubuntu focal main' \
    > /etc/apt/sources.list.d/intel-graphics.list

ARG url=https://repositories.intel.com/graphics/intel-graphics.key
ADD $url /
RUN file=$(basename "$url") && \
    apt-key add "$file" && \
    rm "$file"

RUN apt-get update -y && \
    apt-get install -y \
    intel-opencl-icd \
    intel-level-zero-gpu level-zero \
    intel-media-va-driver-non-free libmfx1




# Clean-up
RUN apt autoremove -y && \
    rm -rf /var/cache/apt /var/lib/apt/lists


COPY ./scripts/setvars-llvm.sh /opt/llvm/setvars.sh
RUN chmod +x /opt/llvm/setvars.sh

#COPY ./test /usr/test

