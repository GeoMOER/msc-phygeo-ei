  # rs-ws-05-2
  # MOC - Data Analysis (T. Nauss, C. Reudenbach)
  # Merging training areas
  
  # Set path ---------------------------------------------------------------------
  if(Sys.info()["sysname"] == "Windows"){
    filepath_base <- "D:/active/moc/msc-phygeo-remote-sensing-2016/"
  } else {
    filepath_base <- "/media/permanent/active/moc/msc-phygeo-remote-sensing-2016/"
  }
  
  path_data <- paste0(filepath_base, "data/")
  path_aerial <- paste0(path_data, "aerial/")
  path_aerial_merged <- paste0(path_data, "aerial_merged/")
  path_aerial_croped <- paste0(path_data, "aerial_croped/")
  path_aerial_final <- paste0(path_data, "aerial_final/")
  path_aerial_aggregated <- paste0(path_data, "aerial_aggregated/")
  path_landcover_training_areas <- paste0(path_data, "landcover/training_areas/")
  path_rdata <- paste0(path_data, "RData/")
  path_scripts <- paste0(filepath_base, "scripts/msc-phygeo-remote-sensing/src/functions/")
  path_temp <- paste0(filepath_base, "temp/")
  
  funs <- list.files(path_scripts, pattern = glob2rx("fun*.R"), full.names = TRUE)
  sapply(funs, source, simplify = TRUE)
  
  
  # Load libraries ---------------------------------------------------------------
  library(car)
  library(raster)
  library(rgdal)
  library(sp)
  
  
  # Merge shape files ------------------------------------------------------------
  # Read names of shape files
  shp_names <- list.files(path_landcover_training_areas, 
                          pattern = glob2rx("*.shp"), full.names = TRUE)
  
  
  
  shps_cmb(shp_names, 
           paste0(path_landcover_training_areas, "muf_training.shp"))
  
  
