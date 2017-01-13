# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Scaling

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}


# Segmentation -----------------------------------------------------------------
filter_files <- list.files(path_muf_set1m, 
                           pattern = glob2rx("*ortho_muf_rgb_idx_pca_*filter*.tif"),
                           full.names = TRUE)
spatial_files <- gsub("filter", "spatial", filter_files)


spatialr_set = c(1, 5, 10)
range_set = c(1, 15, 30)

for(i in seq(length(filter_files))){
  print(i)
  for(spatialr in spatialr_set){
    for(ranger in range_set){
      outfile <- gsub("pca_filter", "pca", filter_files[[i]])
      outfile <- paste0(substr(outfile, 1, nchar(outfile)-4), "_segm_r", spatialr, "_rng", ranger, ".tif")
      muf_lsmss <- otbcli_ExactLargeScaleMeanShiftSegmentation(x = filter_files[[i]],
                                                               inpos = spatial_files[[i]],
                                                               out = outfile,
                                                               tmpdir = path_temp,
                                                               spatialr = spatialr,
                                                               ranger = ranger,
                                                               minsize = 0,
                                                               tilesizex = 1000,
                                                               tilesizey = 1000,
                                                               verbose = FALSE,
                                                               return_raster = FALSE)
    }
  }
}



# Aggregation of areas below minimum size --------------------------------------
segm_files <- list.files(path_muf_set1m, 
                         pattern = glob2rx("*ortho_muf_rgb_idx_pca_*segm*.tif"),
                         full.names = TRUE)
filter_files <- paste0(substr(segm_files, 1, regexpr("_segm", segm_files)-1), ".tif")
# filter_files <- gsub("ortho_muf_rgb_idx_pca_r", "ortho_muf_rgb_idx_pca_filter_r", filter_files)


minsize_set <- seq(5, 50, 5)

for(i in seq(length(segm_files))){
  for(minsize in minsize_set){
    outfile <- paste0(substr(segm_files[[i]], 1, nchar(segm_files[[i]])-4),
                      "_mins", minsize, ".tif")
    muf_lsmss <- otbcli_LSMSSmallRegionsMerging(x = filter_files[[i]],
                                                inseg = segm_files[[i]],
                                                out = outfile,
                                                minsize = minsize,
                                                tilesizex = 1000,
                                                tilesizey = 1000,
                                                verbose = FALSE,
                                                return_raster = FALSE,
                                                ram="8192")
  }
}


# Conversion of segments to polygon shape file ---------------------------------
segm_minsize_files <- list.files(path_muf_set1m, 
                                 pattern = glob2rx("*ortho_muf_rgb_idx_pca_*segm*_mins*.tif"),
                                 full.names = TRUE)
muf <- paste0(path_muf_set1m, "ortho_muf_rgb_idx_pca_scaled.tif")


for(i in seq(180, length(segm_minsize_files))){
  print(i)
  outfile <- paste0(substr(segm_minsize_files[[i]], 1, nchar(segm_minsize_files[[i]])-4),
                    "_vector", ".shp")
  if(!file.exists(outfile)){
    muf_lsmss <- otbcli_LSMSVectorization(x = muf,
                                          inseg = segm_minsize_files[[i]],
                                          out = outfile,
                                          tilesizex = 1000,
                                          tilesizey = 1000,
                                          verbose = FALSE,
                                          ram="8192")
  }
}



