# rs-ws-05-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Scaling

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

funs <- list.files(path_scripts, pattern = glob2rx("fun*.R"), full.names = TRUE)
sapply(funs, source, simplify = TRUE)

library(raster)

rasterOptions(tmpdir = path_temp)

# merge
muf_merged(path_erial_final)

# indices
ngb_idx(infile = paste0(path_aerial_final, "aerial_finalmuf_merged.tif"),
        outfile = paste0(path_aerial_final, "aerial_finalmuf_merged_filter.tif"))

# filter
filter("/home/tnauss/Desktop/scripts/aerial_finalmuf_merged.tif", 
       targetpath = dirname("/home/tnauss/Desktop/scripts/"),
       prefix = "aerial_", window = c(21,29,33),
       statistics = c("homogeneity", "contrast", "correlation", "mean"))


