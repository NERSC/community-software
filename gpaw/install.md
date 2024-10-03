# GPAW install and test directions

##Prerequisite

This version of GPAW depends on libxc ver. 6.2.2. First install libxc
and then edit the `siteconfig.py` to point to location of the install.

##Install

Installing GPAW requires a `siteconfig.py` file tailored to Perlmutter.
This file must be present in the same directory where `setup.py` is run.
The directions below will use the `siteconfig.py` file stored in this
repository. After downloading the file it you may customize it to your
application.

To install run the following commands:

```
module load python cray-fftw
conda create --name gpaw pip numpy scipy matplotlib
source activate gpaw
pip install ase
git clone -b 23.9.1 https://gitlab.com/gpaw/gpaw.git
cd gpaw
wget https://raw.githubusercontent.com/NERSC/community-software/main/gpaw/siteconfig.py -O siteconfig.py
python setup.py build_ext
python setup.py install
```

*NOTE: This will install GPAW ver. 23.9.1.*

*NOTE: If there is an error as follows* when running `python setup.py build_ext`:
```
c/lfc.c: In function ‘construct_density’:
c/lfc.c:526:78: error: ‘PyArray_Descr’ {aka ‘struct _PyArray_Descr’} has no member named ‘elsize’
  526 |     if (!(PyArray_DESCR(rho_MM_obj)->kind == 'f' && PyArray_DESCR(rho_MM_obj)->elsize == 8))
      |                                                                              ^~
c/lfc.c:581:78: error: ‘PyArray_Descr’ {aka ‘struct _PyArray_Descr’} has no member named ‘elsize’
  581 |     if (!(PyArray_DESCR(rho_MM_obj)->kind == 'c' && PyArray_DESCR(rho_MM_obj)->elsize == 16))
      |                                                                              ^~
error: command '/opt/cray/pe/craype/2.7.30/bin/cc' failed with exit code 1,
```
the solution is to remove all `->elsize` in *`GPAW_PATH/c/lfc.c`*


## Run
To run, you'll first need to request an interactive session with the `salloc`
command (see https://docs.nersc.gov/jobs/interactive/#interactive-jobs). Once your
session begins, try the commands:

```
source activate gpaw
export OMP_NUM_THREADS=1
gpaw install-data test-datasets
<when prompted to register the directory with `.../.gpaw/rc.py` select yes>
srun -n 8 -c 2 gpaw test
cat test.txt
```
