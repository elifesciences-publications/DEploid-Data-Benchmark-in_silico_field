# 3 bites
<img src="./k_eq_3.3bitesaltVsRefAndWSAFvsPLAF.png" width="880">

# 2 bites
<img src="./k_eq_3.2bitesaltVsRefAndWSAFvsPLAF.png" width="880">

# 1 bite
<img src="./k_eq_3.1bitesaltVsRefAndWSAFvsPLAF.png" width="880">


```bash
case=k_eq_3.3bites
dataExplore.r -ref alleleCount/africaGroup2.${case}.6p10v30v60.ref -alt alleleCount/africaGroup2.${case}.6p10v30v60.alt -plaf ../../field_haps/africaGroup2_PLAF_14.txt -exclude exclude/africaGroup2.${case}.6.exclude -o ${case}

case=k_eq_3.2bites
dataExplore.r -ref alleleCount/africaGroup2.${case}.6p10v30v60.ref -alt alleleCount/africaGroup2.${case}.6p10v30v60.alt -plaf ../../field_haps/africaGroup2_PLAF_14.txt -exclude exclude/africaGroup2.${case}.6.exclude -o ${case}

case=k_eq_3.1bites
dataExplore.r -ref alleleCount/africaGroup2.${case}.6p10v30v60.ref -alt alleleCount/africaGroup2.${case}.6p10v30v60.alt -plaf ../../field_haps/africaGroup2_PLAF_14.txt -exclude exclude/africaGroup2.${case}.6.exclude -o ${case}
```
