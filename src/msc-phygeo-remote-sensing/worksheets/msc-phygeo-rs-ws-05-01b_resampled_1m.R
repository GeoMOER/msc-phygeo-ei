# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Resample to 1 m

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}

# Crop lidar data --------------------------------------------------------------
lidar_files <- c(paste0(path_lidar_rasters, "lidar_dem_01m.tif"), 
                 paste0(path_lidar_rasters, "lidar_dsm_01m.tif"))

aoi <- readOGR(paste0(path_vectors, "muf_aoi.shp"), layer = "muf_aoi")

for(name in lidar_files){
  crp <- crop(stack(name), extent(aoi), snap = "near")
  projection(crp) <- CRS("+init=epsg:25832")
  writeRaster(crp, filename = paste0(path_muf_set1m, name))
}


# lidar_files <- c(paste0(path_muf_set1m, "lidar_dem_01m.tif"), 
#                  paste0(path_muf_set1m, "lidar_dsm_01m.tif"))
# lidar_diff <- raster(lidar_files[2]) - raster(lidar_files[1])
# writeRaster(lidar_diff, filename = paste0(path_muf_set1m, "lidar_dsr_01m.tif"))



# Resample aerial to LiDAR geometry --------------------------------------------
lidar_template <- raster(paste0(path_lidar_rasters, "lidar_dem_01m_croped.tif"))

aerial_files <- list.files(path_aerial_merged, full.names = TRUE, 
                           pattern = glob2rx("ortho_muf_band*.tif"))
aerial_files <- c(paste0(path_aerial_merged, "ortho_muf.tif"), 
                  aerial_files)


for(name in aerial_files){
  act <- stack(name)
  act_res <- resample(act, lidar_template, method="bilinear")
  outname <- basename(name)
  writeRaster(act_res, filename = paste0(path_muf_set1m, 
                                         substr(outname, 1, nchar(outname)-4),
                                         "_1m.tif"))
}


# Stack bands again ------------------------------------------------------------
aerial_files <- list.files(path_muf_set1m, full.names = TRUE, 
                           pattern = glob2rx("ortho_muf_band*.tif"))

resolution <- c("2_1m", "4_1m", "10_1m")
layers <- c("1m.1", "1m.2", "1m.3", "1m.4")
names <- c("mean", "variance", "skewness", "kurtosis")

for(res in resolution){
  act <- stack(aerial_files[grep(res, aerial_files)])
  
  for(i in seq(length(layers))){
    sub <- act[[grep(layers[i],  names(act))]]
    names(sub) <- paste0(substr(names(sub), 1, nchar(names(sub))-2), "_", names[i])
    writeRaster(sub, 
                filename = paste0(path_muf_set1m, 
                                  "ortho_muf_", 
                                  substr(names(sub)[1], 18, nchar(names(sub)[1])),
                                  ".tif"))
  }
}


