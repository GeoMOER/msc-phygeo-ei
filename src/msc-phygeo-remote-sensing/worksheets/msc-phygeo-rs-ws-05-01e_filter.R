# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Scaling

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ei/src/functions/set_environment.R")
}


# Compute filters --------------------------------------------------------------
# filenames <- c(list.files(path_muf_set1m, pattern = glob2rx("lidar*.tif"), 
#                         full.names = TRUE),
#                list.files(path_muf_set1m, pattern = glob2rx("*PC*.tif"), 
#                           full.names = TRUE),
#                list.files(path_muf_set1m, pattern = glob2rx("*I.tif"), 
#                           full.names = TRUE))

filenames <- c(list.files(path_muf_set1m, pattern = glob2rx("*rgb_idx*.tif"), 
                          full.names = TRUE), 
               list.files(path_muf_set1m, pattern = glob2rx("*I.tif"), 
                          full.names = TRUE))

windows <- c(3, 9, 15, 21)
                        
for(name in filenames){

  for(win in windows){
    act <- raster(name)
    gt <- glcm(act, n_grey = 32, window = c(win, win),
               shift=list(c(0,1), c(1,1), c(1,0), c(1,-1)),
               statistics = c("mean", "variance", "correlation"))
    writeRaster(gt, 
                paste0(substr(name, 1, nchar(name)-4), "_", names(gt), "_w", win, ".tif"),
                bylayer = TRUE)
  }
}

