FROM ubuntu:latest

RUN apt update
RUN apt -y install git g++ ninja-build wget xz-utils libunwind-dev libbfd-dev zlib1g-dev libzstd-dev libiberty-dev

WORKDIR /build
RUN git clone https://github.com/actboy168/luamake
WORKDIR /build/luamake
RUN git submodule init
RUN git submodule update
RUN ./compile/install.sh
RUN ln -s /build/luamake/luamake /usr/local/bin/luamake

COPY . /build/lua-debug
WORKDIR /build/lua-debug
RUN git submodule init
RUN git submodule update
RUN luamake lua compile/download_deps.lua
RUN luamake -mode release


