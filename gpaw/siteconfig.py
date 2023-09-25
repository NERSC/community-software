"""User provided customizations.

Here one changes the default arguments for compiling _gpaw.so.

Here are all the lists that can be modified:

* libraries
  List of libraries to link: -l<lib1> -l<lib2> ...
* library_dirs
  Library search directories: -L<dir1> -L<dir2> ...
* include_dirs
  Header search directories: -I<dir1> -I<dir2> ...
* extra_link_args
  Arguments forwarded directly to linker
* extra_compile_args
  Arguments forwarded directly to compiler
* runtime_library_dirs
  Runtime library search directories: -Wl,-rpath=<dir1> -Wl,-rpath=<dir2> ...
* extra_objects
* define_macros

To override use the form:

    libraries = ['somelib', 'otherlib']

To append use the form

    libraries += ['somelib', 'otherlib']
"""

# flake8: noqa

# compiler = 'gcc'
# platform_id = ''

# MPI:
mpi = True
if mpi:
    compiler = 'cc'

# FFTW3:
fftw = True
if fftw:
    libraries += ['fftw3']

# ScaLAPACK (version 2.0.1+ required):
# ScaLAPACK automatically added by Cray-compiler wrappers on Perlmutter
#scalapack = True
#if scalapack:
#    libraries += ['scalapack']

# Use Elpa (requires ScaLAPACK and Elpa API 20171201):
if 0:
    elpa = True
    elpadir = '/home/user/elpa'
    libraries += ['elpa']
    library_dirs += ['{}/lib'.format(elpadir)]
    runtime_library_dirs += ['{}/lib'.format(elpadir)]
    include_dirs += ['{}/include/elpa-xxxx.xx.xxx'.format(elpadir)]

# LibXC:
# In order to link libxc installed in a non-standard location
# (e.g.: configure --prefix=/home/user/libxc-2.0.1-1), use:

## - static linking:
#if 0:
#    xc = '/home/user/libxc-4.0.4/'
#    include_dirs += [xc + 'include']
#    extra_link_args += [xc + 'lib/libxc.a']
#    if 'xc' in libraries:
#        libraries.remove('xc')

# - dynamic linking (requires rpath or setting LD_LIBRARY_PATH at runtime):
# Uses a temporary install of libxc
if 1:
    xc = '/global/common/software/nersc/user/libxc/6.2.2'
    include_dirs += [xc + 'include']
    library_dirs += [xc + 'lib']
    # You can use rpath to avoid changing LD_LIBRARY_PATH:
    runtime_library_dirs += [xc + 'lib']
    if 'xc' not in libraries:
        libraries.append('xc')

# Enable this, if your MPI doesn't support MPI_INPLACE
if 0:
    undef_macros.append('GPAW_MPI_INPLACE')

# libvdwxc:
if 0:
    libvdwxc = True
    path = '/home/user/libvdwxc'
    include_dirs += ['%s/include' % path]
    library_dirs += ['%s/lib' % path]
    runtime_library_dirs += ['%s/lib' % path]
    libraries += ['vdwxc']

