#!/bin/bash
#SBATCH --job-name=lmp_hybrid        # Job name
#SBATCH --partition=workq            # Need to submit workq for multiple node jobs
#SBATCH --nodes=2                    # Maximum number of nodes to be allocated
#SBATCH --ntasks=4                   # Number of MPI tasks (i.e. processes)
#SBATCH --cpus-per-task=24           # Number of cores per MPI task 
#SBATCH --time=00:05:00              # Wall time limit (hh:mm:ss)
#SBATCH --output=%x_%j.log  # Standard output and error file 

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Slurm Nodes Allocated          = $SLURM_JOB_NODELIST"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"

module load mvapich2/2.3.3/intel-19.0.5
module load lammps/20200303/intel-19.0.5-mvapich-2.3.3

#srun -n $SLURM_NTASKS $(which lmp) -in in.lmp.lj
#export MV2_ENABLE_AFFINITY=0
export MV2_SHOW_CPU_BINDING=1
srun -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK $(which lmp) -in in.lmp.lj -pk omp $SLURM_CPUS_PER_TASK -sf omp

