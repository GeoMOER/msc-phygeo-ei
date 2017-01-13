# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-ui/"
} else {
  filepath_base <- "/media/permanent/active/moc/msc-ui/"
}

path_data <- paste0(filepath_base, "data/")

path_aerial <- paste0(path_data, "aerial/")
path_aerial_croped <- paste0(path_aerial, "croped/")
path_aerial_geomoc <- paste0(path_aerial, "geomoc/")
path_aerial_merged <- paste0(path_aerial, "merged/")
path_aerial_org <- paste0(path_aerial, "org/")
path_aerial_preprocessed <- paste0(path_aerial, "preprocessed/")

path_hessenforst <- paste0(path_data, "hessenforst/")

path_hydrology <- paste0(path_data, "hydrology/")

path_lcc <- paste0(path_data, "lcc/")
path_lcc_training_areas <- paste0(path_data, "lcc/training_areas/")

path_lidar <- paste0(path_data, "lidar/")
path_lidar_rasters <- paste0(path_lidar, "rasters/")

path_rdata <-paste0(path_data, "rdata/") 

path_muf_set1m <- paste0(path_data, "muf_set_1m/")
path_muf_set1m_sample_non_segm <- paste0(path_muf_set1m, "sample_non_segm/")
path_muf_set1m_sample_segm <- paste0(path_muf_set1m, "sample_segm/")
path_muf_set1m_sample_test_01 <- paste0(path_muf_set1m, "sample_test_01/")

path_muf_set_1m_lcc <- paste0(path_data, "muf_set_1m_lcc/")


path_temp <- paste0(path_data, "temp/")

path_vectors <- paste0(path_data, "vectors/")


# Libraries --------------------------------------------------------------------
library(glcm)
library(gpm)
library(mapview)
library(raster)
library(rgdal)
library(rgeos)
library(satelliteTools)
library(sp)


# Functions --------------------------------------------------------------------
path_functions <- paste0(filepath_base, "scripts/msc-phygeo-ei/src/functions/")
fcts <- list.files(path_functions, pattern = glob2rx("*.R"), full.names = TRUE)
sapply(fcts[-which(basename(fcts) == "set_environment.R")], source)


# Other settings ---------------------------------------------------------------
rasterOptions(tmpdir = path_temp)

saga_cmd <- "C:/OSGeo4W64/apps/saga/saga_cmd.exe "
# initOTB("C:/OSGeo4W64/bin/")
initOTB("C:/OSGeo4W64/OTB-5.8.0-win64/OTB-5.8.0-win64/bin/")