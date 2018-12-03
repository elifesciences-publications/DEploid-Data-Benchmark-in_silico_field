#!/usr/bin/env Rscript
rm(list=ls());
source("../../src/src.r")

#library(DEploid)
args = (commandArgs(TRUE))

# ./2bites.r asiaGroup1 k_eq_3 2bites 1

population = args[1]
k_case = args[2]
scenario = args[3]
experimentID = as.numeric(args[4])

trueHap_prefix = panel_prefix = paste(population, k_case, scenario, experimentID, sep = ".")

#experimentID = 1 #as.numeric(args[1])

#prefix = paste("experiment", experimentID, sep ="")
set.seed(experimentID)

fullPanelFile = extract_panel(population)

err<-0.01;

fullSampleNames = names(fullPanelFile)[-c(1,2)]

useSamples = sample(fullSampleNames, 20+3, replace = F)
print(useSamples)
# Use 1-20 samples for panel, 21, 22, 23 for coverage


####################################################################
# Get panel
####################################################################
newPanel.col.idx = c(1, 2, 2+which(fullSampleNames %in% useSamples[-c(21:23)]))
write.table(fullPanelFile[,newPanel.col.idx ], file = paste("panels20/", panel_prefix, ".panel", sep = ""), row.names = F, quote=F, sep="\t")

####################################################################
# Get True haplotypes
####################################################################
totalCoverage = extract_totalCoverage(useSamples[21])
head(totalCoverage)

red_hap = fullPanelFile[[useSamples[21]]]
head(red_hap)
blue_hap = fullPanelFile[[useSamples[22]]]
green_hap = fullPanelFile[[useSamples[23]]]

n.loci = length(red_hap)
breaks.at = 0.5*n.loci

new.hap1 = red_hap
new.hap2 = blue_hap
new.hap3 = green_hap

new.hap2[1:breaks.at] = new.hap1[1:breaks.at]

new.true = data.frame(CHROM = totalCoverage$CHROM,
                      POS = totalCoverage$POS,
                      RED = new.hap1,
                      GREEN = new.hap2,
                      BLUE = new.hap3)
write.table(new.true,
    file = paste("trueHap/", trueHap_prefix, ".truth", sep=""), row.names = F, quote=F, sep="\t")

####################################################################
# Get exclude sites at
####################################################################
exclude.idx = which(rowSums(fullPanelFile[,2+which(fullSampleNames %in% useSamples)]) == 0)
write.table(fullPanelFile[exclude.idx, c(1,2)],
    file = paste("exclude/", trueHap_prefix, ".exclude", sep=""), row.names = F, quote=F, sep="\t")

####################################################################
# Get coverage with different proportions
####################################################################
p1_ary = c(10, 10, 10, 10, 10, 10, 15, 15, 15, 15, 20, 20, 20, 25, 33)
p2_ary = c(10, 15, 20, 25, 30, 40, 15, 20, 25, 30, 20, 25, 30, 25, 33)
#          80, 75, 70, 65, 60, 50, 70, 65, 60, 55, 60, 55, 50, 50, 34
for ( pidx in 1:length(p1_ary) ){
    p1 = p1_ary[pidx]
    p2 = p2_ary[pidx]
    p3 = 100 - p1 - p2

    WSAF1 = new.hap1 * p1/100 + new.hap2 * p2/100 + new.hap3 * p3/100
    includeErrorWSAF1 = WSAF1*(1-err)+(1-WSAF1)*err
    altCount1 = rbinom(n.loci, totalCoverage$total, includeErrorWSAF1)
    refCount1 = totalCoverage$total - altCount1

    write.table(data.frame(CHROM = totalCoverage$CHROM, POS = totalCoverage$POS, REF = refCount1),
        file = paste("alleleCount/",trueHap_prefix, "p", p1,"v", p2, "v", p3, ".ref", sep = ""), row.names = F, quote=F, col.names=T, sep="\t")
    write.table(data.frame(CHROM = totalCoverage$CHROM, POS = totalCoverage$POS, ALT = altCount1),
        file = paste("alleleCount/",trueHap_prefix, "p", p1,"v", p2, "v", p3, ".alt", sep = ""), row.names = F, quote=F, col.names=T, sep="\t")
}
