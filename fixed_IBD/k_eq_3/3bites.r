#!/usr/bin/env Rscript
rm(list=ls());
source("../../src/src.r")

library(DEploid)
args = (commandArgs(TRUE))

# ./3bites.r asiaGroup1 k_eq_3 3bites 1

population = args[1]
k_case = args[2]
scenario = args[3]
experimentID = as.numeric(args[4])

panel_prefix = paste(population, k_case, scenario, experimentID, "txt", sep = ".")

#experimentID = 1 #as.numeric(args[1])

#prefix = paste("experiment", experimentID, sep ="")
set.seed(experimentID)

population = "asiaGroup1"
fullPanelFile = extract_panel(population)

err<-0.01;

fullSampleNames = names(fullPanelFile)[-c(1,2)]

useSamples = sample(fullSampleNames, 20+3, replace = F)

# Use 1-20 samples for panel, 21, 22, 23 for coverage

newPanel.col.idx = c(1, 2, 2+which(fullSampleNames %in% useSamples[-c(21:23)]))
write.table(fullPanelFile[,newPanel.col.idx ], file = paste("panels20/", panel_prefix, ".panel", sep = ""), row.names = F, quote=F, sep="\t")
