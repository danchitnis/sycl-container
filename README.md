# sycl-container

A container for SYCL development

## Initial Step: Build LLVM/SYCL for CUDA

You need an working gpu to build the llvm sycl banch for CUDA. Always run the container with `--gpus all` flag.

Before starting the build make sure that the `./builds` is empty, and you have backed-up the previous builds.

```bash
docker build -f ./llvm-cuda/Dockerfile -t llvm .
```

This will download the CUDA image and clone intel/llvm

```bash
docker run --gpus all -v $(realpath .):/mnt llvm
```

This will start the build process, which may take half-hour. For Windows you need to have a version of WSL2 with GPU passthrough. 


