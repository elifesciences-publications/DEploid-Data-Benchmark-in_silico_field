#!/bin/bash
#$ -cwd
#$ -V
#$ -e ErrFiles
#$ -o OutFiles
#$ -N datasim
#$ -t 1-6

./4bites.r africaGroup2 k_eq_4 4bites ${SGE_TASK_ID}
./3bites.r africaGroup2 k_eq_4 3bites ${SGE_TASK_ID}
./2bites_case1.r africaGroup2 k_eq_4 2bites_case1 ${SGE_TASK_ID}
./2bites_case2.r africaGroup2 k_eq_4 2bites_case2 ${SGE_TASK_ID}
./1bites.r africaGroup2 k_eq_4 1bites ${SGE_TASK_ID}
