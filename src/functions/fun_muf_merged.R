# x = Pfad zu dem Ordner, welcher die tifs enth?lt
# merged alle .tif Dateien des Ordners und speichert das Ergebnis dort ab
# Bsp: muf_merged <- muf_merged(path_aerial_final)

muf_merged<-function(x){
  library(raster)
  read<-list.files(path=x, pattern=glob2rx("*.tif"), full.names=TRUE)
  
  l<-length(read)
  m <- merge(stack(read[1]),stack(read[2]))
  for(i in 3:l){
    m <- merge(m, stack(read[i]))
  }
  writeRaster(m, paste0(x,"muf_merged.tif"))
  return(m)
}