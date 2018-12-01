extract_panel <- function(population){
    panelfile = paste("../../field_haps/", population, "Panel_full_final_14_good.csv.gz", sep = "")
    zz=gzfile(panelfile,'rt')
    fullPanelFile = read.csv(zz, header=T, stringsAsFactors = F, check.names = F)
    return(fullPanelFile)
}
