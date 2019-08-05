# DEploid-Data-Benchmark-in_silico_field

### Description

*In silico* sequence data from field sample simulations.

#### Repository structure

```
/
|## Root directory
|-- field_haps/
|      |## PLAF files, asiaGroup1 and africaGroup2 clonal chromosome 14 haplotypes,
|      |## see README.md for details
|      |-- ...
|      |-- README.md
|
|-- fixed_IBD/
|      |## Directories for different scenarios
|      |-- k_eq_2/
|      |      |## See README.md for details
|      |      |-- ...
|      |      |-- README.md
|      |
|      |-- k_eq_3/
|      |      |## See README.md for details
|      |      |-- ...
|      |      |-- README.md
|      |
|      |-- k_eq_4/
|             |## See README.md for details
|             |-- ...
|             |-- README.md
|
|-- readCounts/
|      |## Contain reference and alternative allele count for 406 field samples, e.g. PF0778-C_Pf3D7_14_v3_ref.txt.gz,
|      |## see README.md for details, and how they were generated.
|      |-- ...
|      |-- README.md
|
|-- README.md
|
|-- src/
|      |## Script source files
|      |-- src.r
|      |-- run.rescomp.deconvolution.src
|
|-- variable_IBD/
       |## Currently empty,
```

<img src="field_haps/image1.jpeg" width="880">


Citation
--------

If you use this validation dataset, please cite the following paper:

Zhu, J. S., J. A. Hendry, J. Almagro-Garcia, R. D. Pearson, R. Amato, A. Miles, D. J. Weiss, T. C. D. Lucas, M. Nguyen, P. W. Gething, D. Kwiatkowski, G. McVean, and for the Pf3k Project. (2018) The origins and relatedness structure of mixed infections vary with local prevalence of *P. falciparum* malaria. *eLife*, doi: http://doi.org/10.7554/eLife.40845.
