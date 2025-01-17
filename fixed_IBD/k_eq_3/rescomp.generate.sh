#!/bin/bash
#$ -cwd
#$ -V
#$ -P mcvean.prjb -q short.qb
#$ -e ErrFiles
#$ -o OutFiles
#$ -N datasim
#$ -t 1-100

./3bites.r asiaGroup1 k_eq_3 3bites ${SGE_TASK_ID}
./2bites.r asiaGroup1 k_eq_3 2bites ${SGE_TASK_ID}
./1bites.r asiaGroup1 k_eq_3 1bites ${SGE_TASK_ID}

./3bites.r africaGroup2 k_eq_3 3bites ${SGE_TASK_ID}
./2bites.r africaGroup2 k_eq_3 2bites ${SGE_TASK_ID}
./1bites.r africaGroup2 k_eq_3 1bites ${SGE_TASK_ID}
