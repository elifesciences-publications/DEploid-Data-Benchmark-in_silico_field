#!/bin/bash
#$ -cwd
#$ -V
#$ -e ErrFiles
#$ -o OutFiles
#$ -N datasim
#$ -t 1-6

./3bites.r asiaGroup1 k_eq_3 3bites ${SGE_TASK_ID}
