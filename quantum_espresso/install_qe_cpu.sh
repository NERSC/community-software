#!/bin/bash

module load cray-fftw
module load cpu

git clone --depth 1 --branch qe-7.2 https://gitlab.com/QEF/q-e qe-7.2-qmcpack
cd qe-7.1-qmcpack-gpu

mkdir build-cpu
cd build-cpu

cmake -DCMAKE_C_COMPILER=cc \
      -DCMAKE_CXX_COMPILER=CC \
      -DQMC_COMPLEX=ON \
      -DCMAKE_SYSTEM_NAME=CrayLinuxEnvironment \
      -DQE_ENABLE_OPENMP=ON \
      -DQE_ENABLE_PLUGINS=pw2qmcpack \
      -DQMC_COMPLEX=ON ..

cmake --build . -j8

# verify

ls bin/pw.x
ls bin/pw2qmcpack.x
