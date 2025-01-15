#=====================================================
# For Linux with intel version 11/12 on 64bit machines
#=====================================================
F90 = ftn
COMMS=mpi
MPIF90=ftn
FCOPTS = -O2 -fpic
FDOPTS = -O2 -fpic

#========================================================
# Intel mkl libraries. Set LIBPATH if not in default path
#========================================================

LIBS = -lmkl_core -lmkl_intel_lp64 -lmkl_sequential -lpthread
