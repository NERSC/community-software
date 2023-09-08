#!/bin/bash -x


# Script to install the CPU version of PETSc

# use 2>&1 | tee petsc_install 

module load gpu
module load cray-hdf5
module list -t

cd $SCRATCH
mkdir TEMP_PETSC_INSTALL
cd TEMP_PETSC_INSTALL

if [ -d $(pwd)/petsc ]
then
  cd petsc
else
  git clone https://gitlab.com/petsc/petsc.git
  cd petsc
fi

export PETSC_DIR=$(pwd)
export PETSC_ARCH=arch-gpu-real

./configure \
  --prefix=$(pwd)/petsc_gpu_real \
  --with-mpiexec=srun \
  --with-make-np=8 \
  --with-batch=0 \
  --with-scalar-type=real \
  --with-64-bit-indices=1 \
  --with-cc=cc \
  --with-cxx=CC \
  --with-fc=ftn \
  --COPTFLAGS=   -g -O3 \
  --CXXOPTFLAGS= -g -O3 \
  --FOPTFLAGS=   -g -O3 \
  --CUDAFLAGS=   -g -O3 \
  --with-debugging=0 \
  --with-cuda=0 \
  --download-hypre \
  --download-metis \
  --download-parmetis \
  --download-hdf5-fortran-bindings \
  --with-cuda=1 \
  --with-cuda-arch=80 \
  --download-viennacl \
  --download-kokkos \
  --download-kokkos-kernals \
  --with-kokkos-kernels-tpl=0

make all
make install
#make -j16 MPIEXEC="srun" test
#
 
