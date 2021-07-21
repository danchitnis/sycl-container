FROM danchitnis/sycl-container:llvm-cuda-base as builder

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt/build/llvm

RUN git pull --verbose

WORKDIR /opt/build/llvm

RUN rm -rf /build/install && \
    export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}} && \
    export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} && \
    export CMAKE_LIBRARY_PATH=/usr/local/cuda-11.4/lib64/stubs && \
    python3 ./buildbot/configure.py --cuda -t release --cmake-gen "Ninja" && \
    cd ./build &&\
    ninja install -j `nproc`


#############################

FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

COPY --from=builder /opt/build/llvm/build/install /opt/llvm

COPY ./scripts/setvars-llvm.sh /opt/llvm/setvars.sh

RUN chmod +x /opt/llvm/setvars.sh

WORKDIR /opt/llvm


