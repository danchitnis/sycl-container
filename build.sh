#!/bin/bash

export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}} && \
export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} && \

shopt -s dotglob
mkdir -p /mnt/builds
mkdir /mnt/builds/llvm-cuda

cd /opt/llvm

# https://www.codeplay.com/solutions/oneapi/for-cuda/#getting-started

python3 ./buildbot/configure.py --cuda -t release --cmake-gen "Unix Makefiles"

cd ./build

make install -j `nproc`

shopt -s dotglob
mv /opt/llvm/build/install/* /mnt/builds/llvm-cuda

echo "Script ended."
echo

