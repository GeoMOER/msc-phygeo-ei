# gi-ws-03-2
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# API calls

# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  filepath_base <- "D:/active/moc/msc-phygeo-gis/"
} else {
  filepath_base <- "/media/permanent/active/moc/msc-phygeo-gis/"
}

path_data <- paste0(filepath_base, "data/")
path_lidar_derivates <- paste0(path_data, "lidar_derivates/")
path_rdata <- paste0(path_data, "RData/")
path_scripts <- paste0(filepath_base, "scripts/msc-phygeo-gis/src/functions/")
path_temp <- paste0(filepath_base, "temp/")

saga_cmd <- "C:/OSGeo4W64/apps/saga/saga_cmd.exe "

# Call SAGA --------------------------------------------------------------------

dem_filepath <- paste0(path_lidar_derivates, "las_intensity_05.tif")

cmd <- paste0(saga_cmd, 
              'io_gdal 0 -GRIDS "D:/active/moc/msc-phygeo-gis/data/temp/dem.sgrd" -FILES ', dem_filepath)
system(cmd)

cmd <- paste0(saga_cmd, 
              'ta_morphometry "Downslope Distance Gradient" -DEM D:/active/moc/msc-phygeo-gis/data/temp/dem.sgrd -DISTANCE 10 -OUTPUT 0 -GRADIENT D:/active/moc/msc-phygeo-gis/data/temp/temp1.tif.sgrd -DIFFERENCE D:/active/moc/msc-phygeo-gis/data/temp/temp2.tif.sgrd')

system(cmd)

cmd <- paste0(saga_cmd, 
              'io_gdal 1 -GRIDS "D:/active/moc/msc-phygeo-gis/data/temp/temp1.tif.sgrd" -FORMAT 4 -TYPE 0 -FILE "D:/active/moc/msc-phygeo-gis/data/temp/temp_1.tif"')

system(cmd)

cmd <- paste0(saga_cmd, 
              'io_gdal 1 -GRIDS "D:/active/moc/msc-phygeo-gis/data/temp/temp2.tif.sgrd" -FORMAT 4 -TYPE 0 -FILE "D:/active/moc/msc-phygeo-gis/data/temp/temp_2.tif"')
system(cmd)
