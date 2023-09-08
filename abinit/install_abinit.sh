#!/bin/bash

set -e 

target=${target:=cpu}
prgenv=${prgenv:=gnu}
version=${version:=9.6.2}
name=abinit

#prefix_root=${prefix_root:= /global/common/software/nersc/testing}
prefix_root=${prefix_root:=$SCRATCH/testing}

prefix=$prefix_root/$name/$version/$prgenv

if [ -d "$prefix" ]; then 
    echo "Prefix directory exists. Please verify install location."
    exit 1
fi


filename=$name-$version.tar.gz

if ! [ -e $prefix/tmp/$filename ]; then
    mkdir -p $prefix/tmp
    url=https://www.abinit.org/sites/default/files/packages/$filename
    wget $url -O $prefix/tmp/$filename
fi

module load PrgEnv-gnu
module load cray-hdf5
module load cray-netcdf


# temporary until libxc module is formalized
module use /pscratch/sd/e/epalmer/LIBXC/modulefile
module load libxc/4.3.4


build_dir=$prefix/build
mkdir -p $build_dir

cd $build_dir 
tar xvf $prefix/tmp/$filename
cd $name-$version

module list

./configure --prefix=$prefix \
    CC="cc" CXX="CC" FC="ftn" \
    FCFLAGS="-fallow-argument-mismatch -ffree-line-length-none" \
    --with-mpi \
    --with-mpi-flavor="native" \
    --enable-mpi-io \
    --with-mpi-level="2" \
    --with-hdf5=$HDF5_ROOT \
    --with-netcdf=$NETCDF_DIR \
    --with-netcdf-fortran=$(nf-config --prefix) \
    --with-libxc=$LIBXC_ROOT 

make -j8


if [ $? -eq 0 ]; then
    make install
fi


## Run tests

# make tests_in

# rm -r $build_dir
# rm -r $prefix/tmp
