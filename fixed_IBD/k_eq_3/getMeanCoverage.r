#!/usr/bin/env Rscript
rm(list=ls());
source("../../src/src.r")

#library(DEploid)
#args = (commandArgs(TRUE))

# ./2bites.r asiaGroup1 k_eq_3 2bites 1

#population = args[1]
#population = "asiaGroup1"
population = "africaGroup2"

#k_case = args[2]
#scenario = args[3]

#experimentID = as.numeric(args[4])
mean_coverage = c()
median_coverage = c()
for (experimentID in 1:100){
    #trueHap_prefix = panel_prefix = paste(population, k_case, scenario, experimentID, sep = ".")

    #experimentID = 1 #as.numeric(args[1])

    #prefix = paste("experiment", experimentID, sep ="")
    set.seed(experimentID)

    fullPanelFile = extract_panel(population)

    err<-0.01;

    fullSampleNames = names(fullPanelFile)[-c(1,2)]

    useSamples = sample(fullSampleNames, 20+2, replace = F)
    print(useSamples)
    # Use 1-20 samples for panel, 21, 22, 23 for coverage


    ####################################################################
    # Get panel
    ####################################################################
#    newPanel.col.idx = c(1, 2, 2+which(fullSampleNames %in% useSamples[-c(21:22)]))
#    write.table(fullPanelFile[,newPanel.col.idx ], file = paste("panels20/", panel_prefix, ".panel", sep = ""), row.names = F, quote=F, sep="\t")

    ####################################################################
    # Get True haplotypes
    ####################################################################
    totalCoverage = extract_totalCoverage(useSamples[21])
    mean_coverage = c(mean_coverage, mean(totalCoverage$total))
    median_coverage = c(median_coverage, median(totalCoverage$total))
}

write.table(data.frame(ID=1:100, mean_coverage, median_coverage), file = paste(population, ".coverage.stats.txt", sep =""), quote=F, row.names=F, sep ="\t")
