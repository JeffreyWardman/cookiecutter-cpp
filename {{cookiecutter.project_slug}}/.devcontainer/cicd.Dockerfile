FROM ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    ccache \
    clang-19 \
    clang-format-19 \
    clang-tidy-19 \
    cmake \
    curl \
    git \
    mold \
    ninja-build \
    pkg-config \
    zip \
    && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-15 150 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-15 150 && \
    update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-15 150 && \
    update-alternatives --install /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-15 150

# Install vcpkg
RUN git clone https://github.com/Microsoft/vcpkg.git /opt/vcpkg && \
    cd /opt/vcpkg && \
    ./bootstrap-vcpkg.sh
ENV PATH=$PATH:/opt/vcpkg

WORKDIR /home

# Install dependencies from vcpkg
COPY vcpkg.json /home/vcpkg.json
RUN /opt/vcpkg/vcpkg install

# Build the project
COPY . .
RUN make build_cicd

CMD ["ctest", "--preset", "linux-cicd", "--output-on-failure", "-j4"]
