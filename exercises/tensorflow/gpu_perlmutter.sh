#!/bin/bash -l

#SBATCH --job-name=tf_distributed
#SBATCH --account=nstaff
#SBATCH --qos=debug
#SBATCH --constraint=gpu
#SBATCH --nodes=1
#SBATCH --gpus=4
#SBATCH --time=00:30:00
#SBATCH --image nvcr.io/nvidia/tensorflow:22.04-tf2-py3

###---Shifter settings

###---Python script containing the training procedure
theScript="distributedMNIST.py"


###---Launching the distributed tensorflow case
srun shifter python $theScript
#srun singularity exec --nv -e -B fake_home:$HOME $theImage python $theScript
