#!/bin/bash -l

#SBATCH --job-name=mpi
#SBATCH --nodes=2
#SBATCH --ntasks=2
#SBATCH --ntasks-per-node=1 -C cpu
#SBATCH --time=00:20:00
#SBATCH --image=quay.io/pawsey/mpich-base:3.4.3_ubuntu23.04

osu_dir="/usr/local/libexec/osu-micro-benchmarks/mpi"


# see that SINGULARITYENV_LD_LIBRARY_PATH is defined (host MPI/interconnect libraries)

# 1st test, with host MPI/interconnect libraries
srun shifter \
  $osu_dir/pt2pt/osu_bw -m 1024:1048576


