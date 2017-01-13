  # rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Extract training area information

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}


# Extract training area information --------------------------------------------
muf <- brick(paste0(path_muf_set1m, "ortho_muf_rgb_idx_scaled_pca_all.vrt"))

# Get corresponding names from virtual raster
muf_names <- read.table(paste0(path_muf_set1m, "ortho_muf_rgb_idx_scaled_pca_all.vrt"),
                        sep = "$", stringsAsFactors = FALSE)
muf_names <- muf_names[grep("SourceFilename", muf_names[,1]),]
muf_names <- lapply(muf_names, function(mf){
  substr(mf, gregexpr(">", mf)[[1]][1]+1, gregexpr("<", mf)[[1]][2]-1)
})
muf_names <- unlist(muf_names)


# Read training shapefile
lc_ta <- readOGR(paste0(path_lcc_training_areas, "muf_training.shp"),
                 "muf_training")
projection(lc_ta) <- CRS("+init=epsg:3044")


# Extract training areas
muf_lc_ta <- extract(muf, lc_ta)

saveRDS(muf_lc_ta, file = paste0(path_lcc_training_areas, "muf_lc_ta.rds"))

muf_lc_ta_cmb <- lapply(seq(length(lc_ta)), function(i){
  if(!is.null(muf_lc_ta[[i]])){
    return(data.frame(ID = lc_ta@data$ID[i],
               NAME = lc_ta@data$NAME[i],
               muf_lc_ta[[i]]))
  } else {
    return(NULL)
  }
})
muf_lc_ta_cmb <- do.call("rbind", muf_lc_ta_cmb)


head(muf_lc_ta_cmb)
saveRDS(muf_lc_ta_cmb, file = paste0(path_lcc_training_areas, "muf_lc_ta_cmb.rds"))

# Add names to extracted training information
colnames(muf_lc_ta_cmb)[3: ncol(muf_lc_ta_cmb)] <- basename(muf_names)
saveRDS(muf_lc_ta_cmb, file = paste0(path_lcc_training_areas, "muf_lc_ta_cmb_names.rds"))


muf_lc_ta_cmb_cc <- muf_lc_ta_cmb[complete.cases(muf_lc_ta_cmb[, -2]),]
saveRDS(muf_lc_ta_cmb_cc, file = paste0(path_lcc_training_areas, "muf_lc_ta_cmb_cc.rds"))




# Extract subsets of training area information ---------------------------------
muf <- brick(paste0(path_muf_set1m, "ortho_muf_rgb_idx_scaled_pca_all.vrt"))

# Get corresponding names from virtual raster
muf_names <- read.table(paste0(path_muf_set1m, "ortho_muf_rgb_idx_scaled_pca_all.vrt"),
                        sep = "$", stringsAsFactors = FALSE)
muf_names <- muf_names[grep("SourceFilename", muf_names[,1]),]
muf_names <- lapply(muf_names, function(mf){
  substr(mf, gregexpr(">", mf)[[1]][1]+1, gregexpr("<", mf)[[1]][2]-1)
})
muf_names <- unlist(muf_names)

# Read training shapefile
lc_ta <- readOGR(paste0(path_lcc_training_areas, "muf_training.shp"),
                 "muf_training")
projection(lc_ta) <- CRS("+init=epsg:3044")

# Extract training areas
lc_ta <- crop(lc_ta, extent(muf))

muf_lc_ta_smpl <- sampleRasterFromPolygons(x = muf, poly = lc_ta, nbr = 50)
saveRDS(muf_lc_ta_smpl, file = paste0(path_lcc_training_areas, "muf_lc_ta_smpl.rds"))

# Add names to extracted training information
colnames(muf_lc_ta_smpl@data)[3: ncol(muf_lc_ta_smpl@data)] <- basename(muf_names)
saveRDS(muf_lc_ta_smpl, file = paste0(path_lcc_training_areas, "muf_lc_ta_smpl_names.rds"))


writeOGR(muf_lc_ta_smpl, paste0(path_lcc_training_areas, "muf_lc_ta_smpl.shp"), "muf_lc_ta_smpl",
         driver = "ESRI Shapefile", overwrite_layer = TRUE)


muf_lc_ta_smpl_cc <- muf_lc_ta_smpl@data[complete.cases(muf_lc_ta_smpl@data[, -2]),]
saveRDS(muf_lc_ta_smpl_cc, file = paste0(path_lcc_training_areas, "muf_lc_ta_smpl_cc.rds"))

