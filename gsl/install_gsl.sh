#!/bin/bash

mkdir $SCRATCH/GSL_BUILD
cd $SCRATCH/GSL_BUILD

wget https://ftp.gnu.org/gnu/gsl/gsl-2.7.1.tar.gz -O gsl-2.7.1.tar.gz
tar xvf gsl-2.7.1.tar.gz

cd gsl-2.7.1

CC=cc ./configure --prefix=$(pwd)/install_dir

make -j8

# runs a series of short checks
#make check

make install
