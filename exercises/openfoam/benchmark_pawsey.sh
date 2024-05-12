#!/bin/bash -l

#SBATCH --job-name=mpi
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --ntasks-per-node=1
#SBATCH --time=00:20:00

image="docker://quay.io/pawsey/mpich-base:3.1.4_ubuntu18.04"
osu_dir="/usr/local/libexec/osu-micro-benchmarks/mpi"

# this configuration depends on the host
module unload xalt
module load singularity


# see that SINGULARITYENV_LD_LIBRARY_PATH is defined (host MPI/interconnect libraries)
echo $SINGULARITYENV_LD_LIBRARY_PATH

# 1st test, with host MPI/interconnect libraries
srun singularity exec $image \
  $osu_dir/pt2pt/osu_bw -m 1024:1048576


# unset SINGULARITYENV_LD_LIBRARY_PATH
unset SINGULARITYENV_LD_LIBRARY_PATH

# 2nd test, without host MPI/interconnect libraries
srun singularity exec $image \
  $osu_dir/pt2pt/osu_bw -m 1024:1048576
