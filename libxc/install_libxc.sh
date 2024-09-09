#!/bin/bash

set -e

name=libxc
version=${version:=6.2.2}
prgenv=${prgenv:=gnu}
target=${target:=cpu}

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
    url=https://gitlab.com/libxc/libxc/-/archive/${version}/libxc-${version}.tar.bz2
    wget $url -O $prefix/tmp/$filename
fi

module load PrgEnv-gnu

build_dir=$prefix/build
mkdir -p $build_dir

cd $build_dir
tar xvf $prefix/tmp/$filename
cd $name-$version

module list

./configure --prefix=$prefix CC="cc" CXX="CC" FC="ftn" CFLAGS="-fPIC"

make -j8


if [ $? -eq 0 ]; then
    make install
fi


## Run tests

# make check

# rm -r $build_dir
# rm -r $prefix/tmp
