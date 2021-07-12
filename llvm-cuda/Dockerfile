FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive

# LLVM layer
RUN apt-get -y update && \
    apt-get -y upgrade

RUN apt-get install -y build-essential python3-dev git cmake ninja-build python3-pip

WORKDIR /opt/
RUN git clone https://github.com/intel/llvm.git -b sycl
#WORKDIR /opt/llvm
#RUN git checkout cf1e717a8fd157c2e13baec7056346668f789743


COPY ./scripts/build.sh /opt

ENTRYPOINT [ "/opt/build.sh" ]
