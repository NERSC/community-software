#!/bin/bash

# This script follows the directions from README.md in the cuDSS Download
# https://developer.nvidia.com/cudss-downloads?target_os=Linux&target_arch=x86_64&Distribution=Agnostic&cuda_version=12



wget https://developer.download.nvidia.com/compute/cudss/redist/libcudss/linux-x86_64/libcudss-linux-x86_64-0.2.1.3_cuda12-archive.tar.xz
tar xvf libcudss-linux-x86_64-0.2.1.3_cuda12-archive.tar.xz

export CMAKE_PREFIX_PATH=$(pwd)/libcudss-linux-x86_64-0.2.1.3_cuda12-archive/lib/cmake:$CMAKE_PREFIX_PATH

cd libcudss-linux-x86_64-0.2.1.3_cuda12-archive/examples

# sets LD_LIBRARY_PATH=${CUDA_PATH}/lib64:${LD_LIBRARY_PATH}
module load PrgEnv-nvidia

mkdir -p build
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_STATIC=0
cmake --build build --verbose
