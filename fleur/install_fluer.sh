#!/bin/bash


git -c http.sslVerify=false clone https://iffgit.fz-juelich.de/fleur/fleur.git
cd fleur
git checkout -t origin/release

module load cpu
module load hdf5




CC=cc CXX=CC FC=ftn ./configure.sh -mpi "yes" -flags "-fallow-argument-mismatch -ffree-line-length-none"

cd build
make -j8




### For testing
###   First request an interactive node, then run the following commands
###
###  need to manually modify `./run_tests.sh` since it contains
###  PYTHON_EXECUTABLE='usr/bin/python3.6'. 

#
#module load conda
#conda activate myenv
#pip install pytest
#
#export juDFT_MPI="srun -n 8"
#./run_tests.sh
