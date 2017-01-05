# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-phygeo-gis/"
} else {
  filepath_base <- "/media/permanent/active/moc/msc-phygeo-gis/"
}

path_data <- paste0(filepath_base, "data/")
path_hydrology <- paste0(path_data, "hydrology/")

saga_cmd <- "C:/OSGeo4W64/apps/saga/saga_cmd.exe "

