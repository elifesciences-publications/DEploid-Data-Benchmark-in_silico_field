#!/bin/bash
#$ -cwd
#$ -V
#$ -e ErrFiles
#$ -o OutFiles
#$ -N datasim
#$ -t 1-6

./4bites.r asiaGroup1 k_eq_4 4bites ${SGE_TASK_ID}
