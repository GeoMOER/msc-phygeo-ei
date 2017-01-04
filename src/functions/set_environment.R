# Set path ---------------------------------------------------------------------
# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-phygeo-remote-sensing/"
} else {
  filepath_base <- "/media/TOSHIBA\ EXT//GFO/BushEncroachment/"
}

path_data <- paste0(filepath_base, "data/")
path_aerial <- paste0(path_data, "aerial/")
path_aerial_org <- paste0(path_data, "aerial/org/")
path_aerial_merged <- paste0(path_data, "aerial_merged/")
path_aerial_croped <- paste0(path_data, "aerial_croped/")
path_lidar_raster <- paste0(path_data, "lidar_rasters/")
path_temp <- paste0(filepath_base, "temp/")


# Libraries --------------------------------------------------------------------
library(glcm)
library(mapview)
library(raster)
library(rgdal)
library(rgeos)
library(satelliteTools)
library(sp)

rasterOptions(tmpdir = path_temp)
