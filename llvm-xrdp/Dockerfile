FROM danchitnis/sycl-container:llvm-dev

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && \
    apt-get -y upgrade

RUN apt-get install -y \
    xfce4 \
    xfce4-clipman-plugin \
    xfce4-cpugraph-plugin \
    xfce4-netload-plugin \
    xfce4-screenshooter \
    xfce4-taskmanager \
    xfce4-terminal \
    xfce4-xkb-plugin && \
    rm -rf /var/cache/apt

RUN apt-get install -y \
    xorgxrdp \
    xrdp && \
    apt remove -y light-locker xscreensaver \
    gedit



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

RUN apt-get -y install cuda-tools-11-4 && \
    rm -rf /var/cache/apt



COPY ./scripts/xrdp_run.sh /usr/bin/run.sh

# https://github.com/danielguerra69/ubuntu-xrdp/blob/master/Dockerfile
RUN mkdir /var/run/dbus && \
    cp /etc/X11/xrdp/xorg.conf /etc/X11 && \
    sed -i "s/console/anybody/g" /etc/X11/Xwrapper.config && \
    sed -i "s/xrdp\/xorg/xorg/g" /etc/xrdp/sesman.ini && \
    echo "xfce4-session" >> /etc/skel/.Xsession


# Docker config
EXPOSE 3389
ENTRYPOINT ["/usr/bin/run.sh"]

