#!/bin/bash -l

#SBATCH --job-name=tf_distributed
#SBATCH --partition=gpuq
#SBATCH --nodes=1
#SBATCH --gres=gpu:2
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00

###---Singularity settings
theImage="docker://nvcr.io/nvidia/tensorflow:22.04-tf2-py3"
module load singularity

###---Python script containing the training procedure
theScript="distributedMNIST.py"


###---Launching the distributed tensorflow case
srun singularity exec --nv -e -B fake_home:$HOME $theImage python $theScript
