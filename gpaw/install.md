# GPAW install and test directions

Installing GPAW requires a `siteconfig.py` file tailored to Perlmutter.
This file must be present in the same directory where `setup.py` is run.
The directions below will use the `siteconfig.py` file stored in this
repository. After downloading the file it you may customize it to your
application.

To install run the following commands:

```
module load python cray-fftw
module use /global/common/software/nersc/user/tmp_modulefile
module load libxc/6.2.2
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
