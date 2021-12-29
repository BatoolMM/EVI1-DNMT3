#!/bin/bash -l
#SBATCH -D ./
#SBATCH --export=ALL
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=6
##SBATCH --mail-user=batool@liverpool.ac.uk
##SBATCH --mail-type=ALL
#SBATCH -t 3-00:00:00
#SBATCH -p gpu
#SBATCH --gres=gpu:2

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load apps/gromacs_cuda/5.1.4/gcc-5.5.0+openmpi-1.10.7+fftw3_float-3.3.4+nvidia-cuda-8.0.61

gmx grompp -f minim.mdp -c pho_solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em -nb gpu
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -deffnm nvt -nb gpu
gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -p topol.top -o npt.tpr
gmx mdrun -deffnm npt -nb gpu
