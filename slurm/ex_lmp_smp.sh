#!/bin/bash
#SBATCH --job-name=lmp_smp         # Job name
#SBATCH -p single                  # For jobs using more than 1 node, submit to workq
#SBATCH --nodes=1                  # Number of nodes to be allocated
#SBATCH --ntasks=1                 # processes
#SBATCH --cpus-per-task=8          # Number of CPU cores per task
#SBATCH --time=00:30:00            # Wall time limit (hh:mm:ss)
#SBATCH --output=%x-%j.log         # Standard output and error 

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Slurm Nodes Allocated          = $SLURM_JOB_NODELIST"
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo 

module load mvapich2/2.3.3/intel-19.0.5
module load lammps/20200303/intel-19.0.5-mvapich-2.3.3

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
/usr/bin/time $(which lmp) -in in.lmp.lj -pk omp $SLURM_CPUS_PER_TASK -sf omp

