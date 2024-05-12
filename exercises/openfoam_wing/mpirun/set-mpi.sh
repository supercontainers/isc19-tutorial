#!/bin/bash 
  
###--- Unloading spack installations
echo "Unloading spack installations"
spack unload openmpi
spack unload mpich
