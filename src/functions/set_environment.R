# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-ui/"
} else {
  filepath_base <- "/media/permanent/active/moc/msc-ui/"
}

path_data <- paste0(filepath_base, "data/")

path_aerial <- paste0(path_data, "aerial/")
path_aerial_preprocessed <- paste0(path_aerial, "preprocessed/")
path_aerial_croped <- paste0(path_aerial, "croped/")
path_aerial_geomoc <- paste0(path_aerial, "geomoc/")
path_aerial_org <- paste0(path_aerial, "org/")

path_hessenforst <- paste0(path_data, "hessenforst/")

path_hydrology <- paste0(path_data, "hydrology/")

path_lidar <- paste0(path_data, "lidar/")
path_lidar_rasters <- paste0(path_lidar, "rasters/")

path_rdata <-paste0(path_data, "rdata/") 

path_temp <- paste0(filepath_base, "temp/")

path_vectors <- paste0(path_data, "vectors/")


# Libraries --------------------------------------------------------------------
library(glcm)
library(mapview)
library(raster)
library(rgdal)
library(rgeos)
library(satelliteTools)
library(sp)


# Functions --------------------------------------------------------------------
path_functions <- "D:/active/moc/msc-phygeo-remote-sensing/scripts/msc-phygeo-remote-sensing/src/functions/"


# Other settings ---------------------------------------------------------------
rasterOptions(tmpdir = path_temp)

saga_cmd <- "C:/OSGeo4W64/apps/saga/saga_cmd.exe "
