# rs-ws-02-2
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Clip aerial images to LAS extent.

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-phygeo-remote-sensing/scripts/msc-phygeo-remote-sensing/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-phygeo-remote-sensing/scripts/msc-phygeo-remote-sensing/src/functions/set_environment.R")
}

# Clip eastern aerial files to LAS extent and write raster to separate file ----
aerial_files <- list.files(path_aerial_org, full.names = TRUE, 
                           pattern = glob2rx("*.tif"))

for(name in aerial_files[-1]){
  act <- stack(name)
  xmin <- as.numeric(substr(basename(name), 1, 6))
  xmax <- xmin + 2000
  ymin <- as.numeric(substr(basename(name), 8, 14))
  ymax <- ymin + 2000
  projection(act) <- CRS("+init=epsg:25832")
  extent(act) <- c(xmin, xmax, ymin, ymax)
  writeRaster(act, filename = paste0(path_aerial, "orto_", basename(name)))
}
