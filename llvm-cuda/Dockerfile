# A container for SYCL development
# Author: Danial Chitnis
# Updated: July 2021

FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive

# LLVM layer

RUN apt-get update && \
    apt-get install -y build-essential python3-dev git cmake ninja-build python3-pip

RUN mkdir /opt/build

WORKDIR /opt/build

#https://github.com/opencv/opencv/issues/6577
#https://github.com/Kitware/fletch/pull/507/files

# for debugging
# RUN git clone https://github.com/intel/llvm.git -b sycl

#for a sepecifc version of LLVM
#git checkout d1556e41db47010ef795ad851439d5d7dbbe4ee5

RUN export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}} && \
    export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} && \
    export CMAKE_LIBRARY_PATH=/usr/local/cuda-11.4/lib64/stubs && \
    git clone https://github.com/intel/llvm.git -b sycl && \
    cd /opt/build/llvm &&\
    #git checkout d1556e41db47010ef795ad851439d5d7dbbe4ee5 && \
    python3 ./buildbot/configure.py --cuda -t release --cmake-gen "Unix Makefiles" && \
    cd ./build &&\
    make install -j `nproc` &&\
    cp -a ./install/. /opt/llvm && \
    cd /opt && \
    rm -rf /opt/build

WORKDIR /opt/llvm

