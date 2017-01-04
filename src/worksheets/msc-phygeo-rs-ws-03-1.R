# rs-ws-03-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Merge "white" aerial images

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-phygeo-remote-sensing/scripts/msc-phygeo-remote-sensing/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-phygeo-remote-sensing/scripts/msc-phygeo-remote-sensing/src/functions/set_environment.R")
}


# Merge aerial files and write resulting raster to separate file ----------------
aerial_files <- list.files(path_aerial, full.names = TRUE, 
                           pattern = glob2rx("*_01.tif"))

for(name1 in aerial_files){
  name2 <- paste0(substr(name1, 1, nchar(name1)-7), ".tif")
  fn <- overlay(stack(name1), stack(name2), fun = min)
  projection(fn) <- CRS("+init=epsg:25832")
  dir.create(path_aerial_merged, showWarnings = FALSE)
  writeRaster(fn, filename = 
                paste0(paste0(path_aerial_merged, basename(name2))))
  
  # Rename original files to mark them
  file.rename(name1, paste0(name1, ".deprc"))
  file.rename(name2, paste0(name2, ".deprc"))
}


