# Prepare combined stack of sentinel 1 and 2 data
# Thomas Nauss

# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-phygeo-remote-sensing-2016/"
} else {
  filepath_base <- "/media/TOSHIBA\ EXT//GFO/BushEncroachment/"
}

path_data <- paste0(filepath_base, "data/")
path_aerial <- paste0(path_data, "aerial/")
path_aerial_merged <- paste0(path_data, "aerial_merged/")
path_temp <- paste0(filepath_base, "temp/")


# Libraries --------------------------------------------------------------------
library(raster)

rasterOptions(tmpdir = path_temp)


# Merge aerial files -----------------------------------------------------------
aerial_files <- list.files(path_aerial, full.names = TRUE, pattern = glob2rx("*(1).tif"))

for(f in aerial_files[2:4]){
  name2 <- paste0(substr(f, 1, nchar(f)-8), ".tif")
  fn <- overlay(stack(f), stack(name2), fun = min)
  dir.create(path_aerial_merged, showWarnings = FALSE)
  writeRaster(fn, filename = 
                paste0(paste0(path_aerial_merged, basename(name2))))
}

