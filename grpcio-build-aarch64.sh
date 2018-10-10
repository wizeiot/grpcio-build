#!/bin/bash
Origin=$(pwd)

# python and boringssl tools
sudo apt-get install python3 python3-pip python3-dev
sudo apt-get install -y automake libtool

# install pip tools
pip3 install setuptools wheel enum34
pip3 install $Origin/tools/coverage-4.5.1-cp35-cp35m-linux_aarch64.whl
pip3 install $Origin/tools/Cython-0.28.3-cp35-cp35m-linux_aarch64.whl

# download and compile instll grpc
export REPO_ROOT=grpc  # REPO_ROOT can be any directory of your choice
REPO_VER=$(curl -L https://grpc.io/release)
# git clone -b v1.15.0 https://github.com/grpc/grpc $REPO_ROOT
git clone -b $REPO_VER https://github.com/grpc/grpc $REPO_ROOT
cd $REPO_ROOT
git submodule update --init
pip3 install -rrequirements.txt
GRPC_PYTHON_BUILD_WITH_CYTHON=1 pip3 install .

# create 
mkdir $Origin/$REPO_VER
cd ~/grpc/src/python/grpcio/grpc
pip3 wheel --wheel-dir=/tmp/wheelhouse grpcio
cp /tmp/wheelhouse/grpcio-* $Origin/$REPO_VER

cd ~/grpc/tools/distrib/python/grpcio_tools/grpc_tools
pip3 wheel --wheel-dir=/tmp/wheelhouse grpcio-tools
cp /tmp/wheelhouse/grpcio_tools-* $Origin/$REPO_VER
