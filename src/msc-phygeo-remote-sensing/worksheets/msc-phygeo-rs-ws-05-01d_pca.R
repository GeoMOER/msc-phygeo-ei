# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Compute pca

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}


# Compute pca ------------------------------------------------------------------
files_muf_rgb <- paste0(path_muf_set1m, "ortho_muf_1m.tif")

files_muf_rgb_idx <- list.files(path_muf_set1m, pattern = glob2rx("*I.tif"),
                           full.names = TRUE)
files_muf_rgb_idx <- c(files_muf_rgb, files_muf_rgb_idx)

files_muf_aerial_all <- list.files(path_muf_set1m, pattern = glob2rx("ortho*.tif"),
                                   full.names = TRUE)

files_muf_aerial_lidar <- c(paste0(path_muf_set1m, "lidar_dsr_01m.tif"),
                            files_muf_aerial_all)

pca_data <- pca(stack(files_muf_rgb))
projection(pca_data$map) <- CRS("+init=epsg:25832")
writeRaster(pca_data$map, 
            paste0(path_muf_set1m, "ortho_muf_rgb_", names(pca_data$map), ".tif"), 
            bylayer = TRUE)

pca_data <- pca(stack(files_muf_rgb_idx))
projection(pca_data$map) <- CRS("+init=epsg:25832")
writeRaster(pca_data$map, 
            paste0(path_muf_set1m, "ortho_muf_rgb_idx_", names(pca_data$map), ".tif"), 
            bylayer = TRUE)

pca_data <- pca(stack(files_muf_aerial_all))
projection(pca_data$map) <- CRS("+init=epsg:25832")
writeRaster(pca_data$map, 
            paste0(path_muf_set1m, "ortho_muf_aerial_all_", names(pca_data$map), ".tif"), 
            bylayer = TRUE)

pca_data <- pca(stack(files_muf_aerial_lidar))
projection(pca_data$map) <- CRS("+init=epsg:25832")
writeRaster(pca_data$map, 
            paste0(path_muf_set1m, "ortho_muf_aerial_lidar_", names(pca_data$map), ".tif"), 
            bylayer = TRUE)


