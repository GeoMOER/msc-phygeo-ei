# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Compute mean shift filter

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}


# Mean shift filtering ---------------------------------------------------------
muf <- paste0(path_muf_set1m, "ortho_muf_rgb_idx_pca_scaled.tif")
# muf <- paste0(path_muf_set_1m_lcc, "ortho_muf_rgb_idx_pca_test.tif")

spatialr_set = c(5, 10)
range_set = c(15, 30)

for(spatialr in spatialr_set){
  for(ranger in range_set){
    outfile_filter <- (paste0(path_muf_set1m, "ortho_muf_rgb_idx_pca_scaled_filter_r", 
                              spatialr, "_rng", ranger, ".tif"))
    
    outfile_spatial <- (paste0(path_muf_set1m, "ortho_muf_rgb_idx_pca_scaled_spatial_r", 
                               spatialr, "_rng", ranger, ".tif"))
    
    muf_msf <- otbcli_MeanShiftSmoothing(x = muf,
                                         outfile_filter = outfile_filter,
                                         outfile_spatial = outfile_spatial,
                                         return_raster = FALSE,
                                         spatialr = spatialr,
                                         ranger = ranger,
                                         thres = 0.1,
                                         maxiter = 100,
                                         rangeramp = 0,
                                         verbose=FALSE,
                                         ram="8192")
  }
}
