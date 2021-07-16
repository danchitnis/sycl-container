#!/bin/bash

export LD_LIBRARY_PATH="/opt/llvm/lib:$LD_LIBRARY_PATH"
export PATH="/opt/llvm/bin:$PATH"

echo variables are set.
echo
echo running clang++ test:
echo

clang++ --version

echo
echo running sycl-ls test:
echo

sycl-ls

echo
echo exiting script.
echo
