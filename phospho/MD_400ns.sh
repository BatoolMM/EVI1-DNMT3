#!/bin/bash -l 
#SBATCH --export=ALL
#SBATCH --nodes=8
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=5
#SBATCH --mail-user=batool@liverpool.ac.uk
#SBATCH --mail-type=ALL
#SBATCH -t 3-00:00:00

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load apps/gromacs/5.1.4/gcc-5.5.0+openmpi-1.10.7+fftw3_float-3.3.4+fftw3_double-3.3.4

gmx grompp -f md_400ns.mdp -c npt.gro -t npt.cpt -p topol.top -o md_400ns.tpr
mpirun  gmx_mpi mdrun -ntomp $SLURM_CPUS_PER_TASK -s md_400ns.tpr -deffnm md_EVI_DNTM3
