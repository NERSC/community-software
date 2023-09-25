# GPAW install and test directions


First you'll need to create a `siteconfig.py` file tailored for Perlmutter.


Then run the following commands:

```
module load python cray-fftw
module use /global/common/software/nersc/user/tmp_modulefile
module load libxc/6.2.2
conda create --name gpaw pip numpy scipy matplotlib
source activate gpaw
pip install ase
python setup.py build_ext
python setup.py install
```


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
