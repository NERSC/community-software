# Flux Installation on Perlmutter: User Notes Courtesy of Nathan Keilbart.

1. Get the Spack installation manager
* Once you have it running, you might need to run
  * `spack compiler find`
  * This will find the compilers currently available in your environment.
2. Install Flux with Spack using:
* `spack install hwloc+cuda`
* `spack install flux-sched+cuda`
* You might be able to get it to work with just the second command but I
  had to back track to find some issues with showed that `hwloc` had to
  be installed with `cuda` to work on the GPUS.
3. Create an interactive allocation
* `salloc -C gpu -A <account> -N 2 --ntasks-per-node=1 --gpus-per-node
  4 -q debug -t 30`
* This will get you two nodes with GPUs but if you don’t want GPUs you
  can drop the commands at the end.
4. Start a Flux manager
* You’ll need to create a script that will call flux from your Spack
  environment. I initially had problems because it was overwriting
  environment files that were needed. I called mine `start_flux.sh`:
  ```bash
  #!/usr/bin/bash
  . /path/to/spack/share/spack/setup-env.sh
  spack load flux-sched
  flux start "$@"
  ```
  You can then start by using `srun -mpi=pmi2 -pty start_flux.sh`
5. From there you can use typical flux commands that are shown in the
   `flux -help` menu.
* For a quick start though you can use these commands:
* `flux submit -N 1 -n 1 <binary>`
* `flux resource list`, will show available resources
* `flux jobs`, show all currently submitted jobs.

## UPDATE: 9/12/23 - Erik Palmer

Steps to run:

1. `module load cpu spack`
2. `spack install flux-sched`
3. `spack install hwloc+cuda+pci+nvml cuda_arch=80`
3. `salloc -C gpu -A <account> -N 2 --gpus-per-node 4 -q debug -t 30`
4. `spack load flux-sched`
5. `flux start -s1`
6. `flux resource list`
7. `flux mini submit -N 1 -n 1 <binary>`
