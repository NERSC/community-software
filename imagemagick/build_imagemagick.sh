#!/bin/bash

# create a directory where you want to build the install and cd into it.

# PREFIX controls where the files will be stored. For long-term use,
# a folder in /global/common/software/... is recommended. In this example, I
# am just testing the install on scratch
PREFIX="/pscratch/sd/e/elvis/Imagemagick_build_folder/install"
VERSION="7.1.1-28"

wget https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${VERSION}.tar.gz

tar xvf ${VERSION}.tar.gz

cd ImageMagick-${VERSION}

./configure CC=cc CXX=CC CFLAGS=-fPIC --enable-shared --prefix=${PREFIX}

make -j 8

make install


# Then you can add the bin folder to your path by putting a link like this
# in .bashrc

export PATH=${PREFIX}/bin:$PATH

# Simple functionality test

convert --version
