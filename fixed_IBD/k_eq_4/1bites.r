#!/usr/bin/env Rscript
rm(list=ls());
source("../../src/src.r")

#library(DEploid)
args = (commandArgs(TRUE))

# ./4bites.r asiaGroup1 k_eq_4 4bites 1

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

useSamples = sample(fullSampleNames, 20+2, replace = F)
print(useSamples)
# Use 1-20 samples for panel, 21, 22, 23, 24 for coverage


####################################################################
# Get panel
####################################################################
newPanel.col.idx = c(1, 2, 2+which(fullSampleNames %in% useSamples[-c(21:22)]))
write.table(fullPanelFile[,newPanel.col.idx ], file = paste("panels20/", panel_prefix, ".panel", sep = ""), row.names = F, quote=F, sep="\t")
system(paste("gzip panels20/", panel_prefix, ".panel", sep = ""))

####################################################################
# Get True haplotypes
####################################################################
totalCoverage = extract_totalCoverage(useSamples[21])
head(totalCoverage)

red_hap = fullPanelFile[[useSamples[21]]]
head(red_hap)
blue_hap = fullPanelFile[[useSamples[22]]]

n.loci = length(red_hap)
breaks.at.1 = 0.25*n.loci
breaks.at.2 = 0.5*n.loci
breaks.at.3 = 0.75*n.loci

new.hap1 = red_hap
new.hap2 = red_hap
new.hap3 = red_hap
new.hap4 = blue_hap

new.hap2[breaks.at.1:breaks.at.3] = blue_hap[breaks.at.1:breaks.at.3]
new.hap1[1:breaks.at.1] = blue_hap[1:breaks.at.1]

new.hap4[1:breaks.at.2] = red_hap[1:breaks.at.2]
new.hap3[1:breaks.at.3] = blue_hap[1:breaks.at.3]


new.true = data.frame(CHROM = totalCoverage$CHROM,
                      POS = totalCoverage$POS,
                      RED = new.hap1,
                      GREEN = new.hap2,
                      BLUE = new.hap3,
                      BLACK = new.hap4)
write.table(new.true,
    file = paste("trueHap/", trueHap_prefix, ".truth", sep=""), row.names = F, quote=F, sep="\t")
system(paste("gzip trueHap/", trueHap_prefix, ".truth", sep=""))

####################################################################
# Get exclude sites at
####################################################################
exclude.idx = which(rowSums(cbind(fullPanelFile[,2+which(fullSampleNames %in% useSamples)], totalCoverage$ALT)) == 0)
write.table(fullPanelFile[exclude.idx, c(1,2)],
    file = paste("exclude/", trueHap_prefix, ".exclude", sep=""), row.names = F, quote=F, sep="\t")
system(paste("gzip exclude/", trueHap_prefix, ".exclude", sep=""))

####################################################################
# Get coverage with different proportions
####################################################################
n.loci = length(red_hap)
p1_ary = c(11, 25, 20, 30)
p2_ary = c(22, 25, 20, 30)
p3_ary = c(30, 25, 20, 30)
#          37, 25, 40, 10

for ( pidx in 1:length(p1_ary) ){
    p1 = p1_ary[pidx]
    p2 = p2_ary[pidx]
    p3 = p3_ary[pidx]
    p4 = 100 - p1 - p2 - p3

    WSAF1 = new.hap1 * p1/100 + new.hap2 * p2/100 + new.hap3 * p3/100 + new.hap4 * p4 / 100
    includeErrorWSAF1 = WSAF1*(1-err)+(1-WSAF1)*err
    altCount1 = rbinom(n.loci, totalCoverage$total, includeErrorWSAF1)
    refCount1 = totalCoverage$total - altCount1

    write.table(data.frame(CHROM = totalCoverage$CHROM, POS = totalCoverage$POS, REF = refCount1),
        file = paste("alleleCount/",trueHap_prefix, "p", p1,"v", p2, "v", p3, "v", p4, ".ref", sep = ""), row.names = F, quote=F, col.names=T, sep="\t")
    system(paste("gzip alleleCount/",trueHap_prefix, "p", p1,"v", p2, "v", p3, "v", p4, ".ref", sep = ""))
    write.table(data.frame(CHROM = totalCoverage$CHROM, POS = totalCoverage$POS, ALT = altCount1),
        file = paste("alleleCount/",trueHap_prefix, "p", p1,"v", p2, "v", p3, "v", p4, ".alt", sep = ""), row.names = F, quote=F, col.names=T, sep="\t")
    system(paste("gzip alleleCount/",trueHap_prefix, "p", p1,"v", p2, "v", p3, "v", p4, ".alt", sep = ""))
}
