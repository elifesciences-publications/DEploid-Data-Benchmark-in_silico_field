Getting a list of discarded haplotypes

```R
a = read.table("../pf3k-IBD-deconvolution-clean-version/haplotypes-quality-filtered-final-drop-Point01-Strain-collapse-point94-relatedness.tab", header=T, sep ="\t", stringsAsFactors=F)
write.table(unique(a$isolate[which(a$discarded)]), file = "discard.samples", quote = F, row.names=F, col.names=F)
```

```R
zz=gzfile("asiaGroup1Panel_full_final_14.csv.gz",'rt')
fullPanelFile = read.csv(zz, header=T, stringsAsFactors = F, check.names = F)
discard = read.table("discard.samples", stringsAsFactors=F, header=F)$V1
write.csv(fullPanelFile[,which(!names(fullPanelFile) %in% discard)], file = "asiaGroup1Panel_full_final_14_good.csv", quote = F, row.names=F)
close(zz)

zz=gzfile("africaGroup2Panel_full_final_14.csv.gz",'rt')
fullPanelFile = read.csv(zz, header=T, stringsAsFactors = F, check.names = F)
discard = read.table("discard.samples", stringsAsFactors=F, header=F)$V1
write.csv(fullPanelFile[,which(!names(fullPanelFile) %in% discard)], file = "africaGroup2Panel_full_final_14_good.csv", quote = F, row.names=F)
close(zz)
```
