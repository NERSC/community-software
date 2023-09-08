#!/bin/bash -x


# Script to install the CPU version of PETSc

# use 2>&1 | tee petsc_install 

module load cpu
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
export PETSC_ARCH=arch-cpu-real

./configure \
  --prefix=$(pwd)/petsc_cpu_real \
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
  --download-hdf5-fortran-bindings

make all
make install
#make -j64 test
#
 
