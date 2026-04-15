ARG UBUNTU_24_04="ubuntu@sha256:e21f810fa78c09944446ec02048605eb3ab1e4e2e261c387ecc7456b38400d79"
FROM ${UBUNTU_24_04}

ENV TIPI_DISTRO_MODE=default
ENV TIPI_INSTALL_LEGACY_PACKAGES=OFF

RUN apt-get update 
# Install build requirements.
RUN apt install -y autoconf automake libtool make curl
# Install tools used during the build of various projects.
RUN apt install -y file debianutils libxkbcommon-x11-dev libgl1-mesa-dev python3 libpython3-dev python3-pip libfindbin-libs-perl libperl-dev bison flex libxext-dev libxrandr-dev libxcb-util0-dev libxcb-image0-dev libxcb-keysyms1-dev libxcb-render-util0-dev libegl1-mesa-dev python3-venv libx11-dev libopenmpi-dev
# Install development tools
RUN apt install -y git-core git-lfs
# Install toolchains.
RUN apt install -y g++ gcc gfortran

RUN curl -fsSL https://raw.githubusercontent.com/tipi-build/cli/bf984045460fb3cb1730d58056ac32437f0b2a01/install/container/ubuntu.sh -o ubuntu.sh && /bin/bash ubuntu.sh && chmod 777 /usr/local/share/.tipi/.distro.mode && chmod -R 777 /usr/local/share/.tipi
USER tipi
WORKDIR /home/tipi
EXPOSE 22