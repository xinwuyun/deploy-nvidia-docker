FROM nvidia/cuda:8.0-devel-ubuntu16.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

ENV PATH /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y software-properties-common && add-apt-repository -y ppa:wine/wine-builds && dpkg --add-architecture i386 && apt-get upgrade -y && apt-get install -y git net-tools qemu-kvm qemu nvidia-modprobe virt-manager virt-viewer libvirt-bin net-tools wget && apt-get clean all

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y  --install-recommends xfce4 xfce4-goodies libsdl1.2-dev mesa-utils && apt-get clean all

RUN export DEBIAN_FRONTEND=noninteractive && apt-get install -y x11vnc  tightvncserver vnc4server novnc xvfb firefox mc lynx open-vm-tools && apt-get clean all

RUN apt-get -y -f install libtasn1-3-bin && apt-get update && apt-get install -y wine-staging && apt-get clean all && apt -y autoremove

RUN apt-get -y -f install ocl-icd-libopencl1 opencl-headers ocl-icd-opencl-dev beignet lm-sensors hddtemp python-pip clinfo freeglut3 && apt-get clean all && apt -y autoremove

RUN cd /root && wget http://upload.aspeedtech.com/BIOS/v103_linux_freebsd_solaris.zip && unzip /root/v103_linux_freebsd_solaris.zip

RUN cd /root &&git clone git://github.com/novnc/noVNC v1.0.0-testing.2 && mv v1.0.0-testing.2 noVNC && cp /root/noVNC/vnc.html /root/noVNC/index.html && mkdir /root/.vnc

RUN cd /root &&wget http://archive.ubuntu.com/ubuntu/dists/trusty/main/installer-amd64/current/images/netboot/mini.iso && wget http://www.luxrender.net/release/luxmark/v3.1/luxmark-linux64-v3.1.tar.bz2

COPY run /root
RUN chmod 755 /root/run

COPY run-nv /root
RUN chmod 755 /root/run-nv

COPY xorg.conf /usr/share/X11/xorg.conf.d/
COPY passwd /root/.vnc/
COPY xstartup /root/.vnc/

RUN chmod 755 /root/.vnc/xstartup

EXPOSE 5900 6080
