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

## VScode container

install the VScode [remote container extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).

```bash
git clone https://github.com/danchitnis/sycl-container.git
cd sycl-container
```

Go to the VScode remote container extension and click on the reopen the current folder in a container link. Once the container is running, then type `bash` in the terminal and press enter. Then type `. /opt/llvm/setvars.sh` and press enter.

## Quick tests

First, make sure you have the docker container running, either using llvm-dev or the VScode container, and you have the environment variables set using the instructions above. There are tests codes in the `./test` folder.

### device query

The simple prints all the SYCL devices available on the system. Compile the code with the following command

```bash
clang++ -fsycl device_query.cpp -o device_query
```

run the code with the following command

```bash
./device_query
```

### simple loop

For the OpenCL backend you need to compile the code with the following command:

```bash
clang++ -fsycl simple_loop.cpp - o simple_loop_opencl
```

run the test with the following command:

```bash
DEVICE_TYPE_FILTER=opencl,host ./simple_loop_opencl
```

For the CUDA backend you need to compile the code with the following command:

```bash
clang++ -fsycl -fsycl-targets=nvptx64-nvidia-cuda-sycldevice simple_loop.cpp -o simple_loop_cuda
```

run the test with the following command:

```bash
DEVICE_TYPE_FILTER=cuda,host ./simple_loop_cuda
```

## GUI interface with XRDP

For Windows users you can use the Remote Desktop Protocol (XRDP) to connect to the container and run full GUI applications including profilers.

```bash
docker pull danchitnis/sycl-container:llvm-xrdp
```

```bash
docker run -it --gpus all -v $(realpath .):/mnt -p 33890:3389 danchitnis/sycl-container:llvm-xrdp foo bar yes
```

Then open Remote Desktop Connection and connect to the hostname `localhost:33890`. When prompted for the credentials, enter the username and password of the user `foo` and `bar`.

## Build from source

```bash
git clone https://github.com/danchitnis/sycl-container.git
cd sycl-container
```

```bash
docker build -f ./llvm-cuda/Dockerfile -t danchitnis/sycl-container:llvm-cuda .
```

```bash
docker build -f ./llvm-dev/Dockerfile -t danchitnis/sycl-container:llvm-dev .
```

## Contributions
