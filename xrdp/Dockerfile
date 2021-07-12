FROM nvidia/cuda:11.4.0-devel-ubuntu20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update 
RUN apt-get -y upgrade

RUN apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin

RUN apt-get install -y \
    xorgxrdp \
    xrdp && \
    apt remove -y light-locker xscreensaver

RUN apt-get install -y \
    sudo \
    wget \
    gedit \
    curl

RUN apt-get install -y build-essential python3-dev git cmake python3-pip software-properties-common

#install CUDA tools
#https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#package-manager-metas
#https://developer.nvidia.com/blog/nvidia-nsight-systems-containers-cloud/
#https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
    mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub && \
    add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
    apt-get -y update

RUN apt-get -y install cuda-tools-11-4



#Intel OpenCl
#https://software.intel.com/content/www/us/en/develop/documentation/installation-guide-for-intel-oneapi-toolkits-linux/top/installation/install-using-package-managers/apt.html
RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB -O - | sudo apt-key add - && \
    echo "deb https://apt.repos.intel.com/oneapi all main" | sudo tee /etc/apt/sources.list.d/oneAPI.list && \
    sudo add-apt-repository "deb https://apt.repos.intel.com/oneapi all main" && \
    apt-get -y update

# https://software.intel.com/content/www/us/en/develop/articles/intel-cpu-runtime-for-opencl-applications-with-sycl-support.html
# https://oneapi-src.github.io/oneapi-ci/
RUN apt-get -y install intel-oneapi-runtime-opencl intel-oneapi-runtime-tbb

RUN ln -s /mnt/builds/llvm-cuda /opt/intel/llvm



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


COPY ./scripts/setvars.sh /opt/intel

COPY ./scripts/run.sh /usr/bin/

# https://github.com/danielguerra69/ubuntu-xrdp/blob/master/Dockerfile
RUN mkdir /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession


# Docker config
EXPOSE 3389
ENTRYPOINT ["/usr/bin/run.sh"]

