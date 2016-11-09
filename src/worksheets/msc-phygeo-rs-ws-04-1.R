# rs-ws-03-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Check radiometric image alignment

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
path_rdata <- paste0(path_data, "RData/")
path_scripts <- paste0(filepath_base, "scripts/msc-phygeo-remote-sensing/src/functions/")
path_temp <- paste0(filepath_base, "temp/")


# Libraries --------------------------------------------------------------------
library(rgdal)
library(raster)

rasterOptions(tmpdir = path_temp)


# Read aerial files from different directories and create consistent list ------
aerial_files <- list.files(path_aerial, full.names = TRUE, 
                           pattern = glob2rx("*0.tif"))
aerial_files_merged <- list.files(path_aerial_merged, full.names = TRUE, 
                                  pattern = glob2rx("*.tif"))
aerial_files_croped <- list.files(path_aerial_croped, full.names = TRUE, 
                                  pattern = glob2rx("*.tif"))

aerial_files_group <- c(aerial_files_merged, aerial_files_croped)

for(f in seq(length(aerial_files))){
  pos <- grep(basename(aerial_files[f]), basename(aerial_files_group))
  if(length(pos) == 0){
    aerial_files_group[length(aerial_files_group)+1] <- aerial_files[f]
  }
}

aerial_files <- aerial_files_group[order(basename(aerial_files_group))]


# Extract border data of aerial files ------------------------------------------
for(f in aerial_files){
  act_file <- stack(f)
  print(projection(f))
  writeRaster(act_file, filename = paste0(path_aerial_final, basename(f)))
}

