# rs-ws-05-2
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Remove nas

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

rasterOptions(tmpdir = path_temp)


r <- raster(paste0(path_aerial_aggregated, "geonode_muf_merged_001m_redness_index_mean_21.tif"))
d <- getValues(r)
summary(d)
d[is.na(d)] <- 0
r <- setValues(r, d)
projection(r) <- CRS("+init=epsg:25832")
writeRaster(r, paste0(path_aerial_aggregated, 
                      "geonode_muf_merged_001m_redness_index_mean_21_nona.tif"),
            overwrite = TRUE)

# dmin <- min(d, na.rm = TRUE)
# dmax <- max(d, na.rm = TRUE)
# d_new <- (d - dmin) * (255 - 0) / (dmax - dmin) + 0
# summary(d_new)
# r <- setValues(r, d)
# projection(r) <- CRS("+init=epsg:25832")
# writeRaster(r, paste0(path_aerial_aggregated, 
#                       "geonode_muf_merged_001m_redness_index_mean_21_scaled.tif"),
#             overwrite = TRUE)


files <- list.files(path_aerial_aggregated, pattern = glob2rx("*index.tif"),
                    full.names = TRUE)
for(f in files){
  r <- raster(f)
  d <- getValues(r)
  d[is.na(d)] <- 0
  r <- setValues(r, d)
  projection(r) <- CRS("+init=epsg:25832")
  of <- paste0(substr(f, 1, nchar(f)-4), "_nona.tif")
  writeRaster(r, of, overwrite = TRUE)
}