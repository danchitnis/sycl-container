# sycl-container

A container for SYCL development.

## Quick start

make sure you have docker installed and running on your system. For CUDA see the notes below.

```bash
docker pull danchitnis/sycl-container:llvm-dev
```

once the download is complete, then run

```bash
docker run -it --gpus all danchitnis/sycl-container:llvm-dev bash
```

once inside the container, then set your environment variables

```bash
. /opt/llvm/setvars.sh
```

This will set the essential variables to compile and run SYCL code. It will run `clang++ --version` and `sycl-ls` as a test.

## Contributions
