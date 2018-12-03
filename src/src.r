extract_panel <- function(population){
    panelfile = paste("../../field_haps/", population, "Panel_full_final_14_good.csv.gz", sep = "")
    zz=gzfile(panelfile,'rt')
    fullPanelFile = read.csv(zz, header=T, stringsAsFactors = F, check.names = F)
    close(zz)
    return(fullPanelFile)
}


extract_totalCoverage <- function(sampleName){
    refFileName = paste("../../readCounts/", sampleName, "_Pf3D7_14_v3_ref.txt.gz", sep="")
    altFileName = paste("../../readCounts/", sampleName, "_Pf3D7_14_v3_alt.txt.gz", sep="")

    zref = gzfile(refFileName,'rt')
    ref = read.table(zref, header=T, stringsAsFactors = F, check.names = F)

    zalt = gzfile(altFileName,'rt')
    alt = read.table(zalt, header=T, stringsAsFactors = F, check.names = F)

    total = ref[,3] + alt[,3]
    coverage = data.frame(CHROM = ref$CHROM,
                          POS = ref$POS,
#                          REF = ref[,3],
#                          ALT = alt[,3],
                          total = total)
    close(zref)
    close(zalt)
    return(coverage)
}
