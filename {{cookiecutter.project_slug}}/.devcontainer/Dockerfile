FROM gcc:13.2

ARG CMAKE_VERSION=3.27.1

RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.sh \
    -q -O /tmp/cmake-install.sh \
    && chmod u+x /tmp/cmake-install.sh \
    && mkdir /usr/bin/cmake \
    && /tmp/cmake-install.sh --skip-license --prefix=/usr/bin/cmake \
    && rm /tmp/cmake-install.sh

ENV PATH="/usr/bin/cmake/bin:${PATH}"

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    software-properties-common \
    git \
    curl \
    unzip \
    tar \
    zip \
    clang \
    clangd \
    clang-format && \
    mkdir /home/project

RUN git clone https://github.com/Microsoft/vcpkg.git /opt/vcpkg
WORKDIR /opt/vcpkg
RUN ./bootstrap-vcpkg.sh && ./vcpkg integrate install && ./vcpkg integrate bash && echo 'export PATH=$PATH:/opt/vcpkg' >>~/.bashrc

WORKDIR /root
COPY vcpkg.json /root/vcpkg.json
RUN /opt/vcpkg/vcpkg install && rm vcpkg.json

CMD ["bash"]
