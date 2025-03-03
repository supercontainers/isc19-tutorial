#!/bin/bash

NTASKS="2"
image="library://marcodelapierre/beta/openfoam:v2012"

# this configuration depends on the host
PATH=/opt/intel/oneapi/mpi/latest/bin:/bin:/usr/bin:/usr/local/bin

export MPICH_ROOT="/opt/intel/oneapi"
export MPICH_RUN="$( which mpirun )"
export MPICH_BASE="${MPICH_RUN%/bin/mpirun*}"

export SINGULARITY_BINDPATH="$MPICH_ROOT"
export SINGULARITYENV_LD_LIBRARY_PATH="$MPICH_BASE/lib/release:$MPICH_BASE/libfabric/lib:\$LD_LIBRARY_PATH"


# pre-processing
singularity exec $image \
  blockMesh | tee log.blockMesh

singularity exec $image \
  topoSet | tee log.topoSet

singularity exec $image \
  decomposePar -fileHandler uncollated | tee log.decomposePar


# run OpenFoam with MPI
mpirun -n $NTASKS \
  singularity exec $image \
  simpleFoam -fileHandler uncollated -parallel | tee log.simpleFoam


# post-processing
singularity exec $image \
  reconstructPar -latestTime -fileHandler uncollated | tee log.reconstructPar

