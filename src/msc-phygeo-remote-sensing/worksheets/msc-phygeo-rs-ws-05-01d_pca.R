# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Compute pca

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}


# Compute spectral indices -----------------------------------------------------
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


# Compute PCA ------------------------------------------------------------------
# pca <- pca(stack(muf))
# saveRDS(pca, file = paste0(path_rdata, "ortho_muf_pca.RDS"))
# projection(pca$map) <- CRS("+init=epsg:25832")
# writeRaster(pca$map, paste0(path_aerial_merged, "ortho_muf_", names(pca$map), ".tif"), 
#             bylayer = TRUE)
pca <- stack(paste0(path_aerial_merged, "ortho_muf_", c("PC1", "PC2", "PC3"), ".tif"))


# Compute local statistics -----------------------------------------------------
rad <- c(25, 50)
rad <- c(2, 4, 10)

muf_files <- c(paste0(path_aerial_merged, "ortho_muf_", c("GLI", "NGRDI", "TGI", "VVI"), ".tif"),
               paste0(path_aerial_merged, "ortho_muf_", c("PC1", "PC2", "PC3"), ".tif"))
muf_files <- paste0(path_aerial_merged, "ortho_muf.tif")

for(n in muf_files){
  for(r in rad){
    print(paste0("Processing ", n, " ", r))
    otb_local_statistics <- otbLocalStat(x = n, 
                                         output_name = tools::file_path_sans_ext(basename(n)),
                                         path_output = path_aerial_merged,
                                         channel = seq(3),
                                         radius = r,
                                         return_raster = FALSE)
  }
}




# Filter   indices -----------------------------------------------------
filter("/home/tnauss/Desktop/scripts/aerial_finalmuf_merged.tif", 
       targetpath = dirname("/home/tnauss/Desktop/scripts/"),
         prefix = "aerial_", window = c(21,29,33),
         statistics = c("homogeneity", "contrast", "correlation", "mean"))


