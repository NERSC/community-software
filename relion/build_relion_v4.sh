#!/bin/bash

module load cray-fftw



git clone -b 4.0.1 https://github.com/3dem/relion.git

cd relion

mkdir build; cd build
mkdir install

cmake --fresh .. \
  -D CMAKE_INSTALL_PREFIX=$(realpath ./install) \
  -D GUI=OFF \
  -D CUDA_SDK_ROOT_DIR="/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/math_libs/12.2" \
  -D CUDA_cublas_LIBRARY="/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/math_libs/12.2/lib64/libcublas.so" \
  -D CUDA_cufft_LIBRARY="/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/math_libs/12.2/lib64/libcufft.so" \
  -D CUDA_curand_LIBRARY="/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/math_libs/12.2/lib64/libcurand.so" \
  -D CUDA_cusolver_LIBRARY="/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/math_libs/12.2/lib64/libcusolver.so" \
  -D CUDA_cusparse_LIBRARY="/opt/nvidia/hpc_sdk/Linux_x86_64/23.9/math_libs/12.2/lib64/libcusparse.so" 

cmake --build . -j8


cmake --install .
