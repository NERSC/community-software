#!/bin/bash

mkdir $SCRATCH/TEST_GROMACS
cd $SCRATCH/TEST_GROMACS

git clone --branch v2018.2 https://github.com/gromacs/gromacs.git 



cd gromacs
sed -i '54i#include<limits>' ./src/gromacs/utility/arrayref.h
sed -in '122,138s/^\([^ ]*\)/#/' ./cmake/gmxManageNvccConfig.cmake
sed -in '146,153s/^\([^ ]*\)/#/' ./cmake/gmxManageNvccConfig.cmake

mkdir build
cd build

module load PrgEnv-gnu
module load gpu
module load cmake/3.24.3
module load cray-fftw
module load python

cmake .. -DGMX_GPU=CUDA \
         -DGMX_MPI=ON \
         -DCMAKE_INSTALL_PREFIX="$(pwd)/install_dir" \
         -DGMX_BUILD_OWN_FFTW=OFF \
         -DREGRESSIONTEST_DOWNLOAD=OFF \
         -DGMX_HWLOC=OFF \
         -DCUDA_cufft_LIBRARY="/opt/nvidia/hpc_sdk/Linux_x86_64/22.7/math_libs/11.7/lib64/libcufft.so"

cmake --build . -j16


#make check  # Requires interactive or batch job

cmake --install .


