FROM nvidia/cuda:11.4.0-devel-ubuntu20.04
#FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive

# LLVM layer

RUN apt-get update && \
    apt-get install -y build-essential python3-dev git cmake ninja-build python3-pip

RUN mkdir /opt/build

WORKDIR /opt/build

#WORKDIR /opt/llvm
#RUN git checkout cf1e717a8fd157c2e13baec7056346668f789743

RUN export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}} && \
    export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} && \
    export CMAKE_LIBRARY_PATH=/usr/local/cuda-11.4/lib64/stubs && \
    git clone https://github.com/intel/llvm.git -b sycl && \
    cd /opt/build/llvm &&\
    python3 ./buildbot/configure.py --cuda -t release --cmake-gen "Unix Makefiles" && \
    cd ./build &&\
    make install -j `nproc` &&\
    cp -a ./install/. /opt/llvm && \
    cd /opt && \
    rm -rf /opt/build

WORKDIR /opt/llvm

