#!/bin/bash
#

PATH=/opt/spack/opt/spack/spack_path_placeholder/spack_path_placeholder/spack_path_placeholder/spack_path_placeholder/s/linux-amzn2-x86_64/gcc-7.3.1/mpich-3.3.2-q546vjf5teafqxsttapjokurnarsx5iz/bin/:$PATH

NTASKS="2"
image="library://marcodelapierre/beta/openfoam:v2012"

# this configuration depends on the host
export MPICH_ROOT="/opt/spack"
#export MPICH_ROOT="/opt/intel/oneapi"
export MPICH_LIBS="$( which mpirun )"
export MPICH_LIBS="${MPICH_LIBS%/bin/mpirun*}/lib"

export SINGULARITY_BINDPATH="$MPICH_ROOT"
export SINGULARITYENV_LD_LIBRARY_PATH="$MPICH_LIBS:$MPICH_LIBS/libfabric:\$LD_LIBRARY_PATH"



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

