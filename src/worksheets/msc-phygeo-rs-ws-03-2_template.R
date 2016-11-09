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
path_rdata <- paste0(path_data, "RData/")
path_scripts <- paste0(filepath_base, "scripts/msc-phygeo-remote-sensing/src/functions/")
path_temp <- paste0(filepath_base, "temp/")


# Libraries --------------------------------------------------------------------
library(raster)
library(tools)
source(paste0(path_scripts, "fun_ngb_aerials.R")) # Load functions from scripts

rasterOptions(tmpdir = path_temp)


# Get filepath of aerial tiles -------------------------------------------------
# ...

# To use the function, just call it
neighbours <- ngb_aerials(...)

#...

# Save intermediate results which form the basis for the descriptive analysis  -
# This example assumes that the results are stored in the variable "results".
saveRDS(results, file = paste0(path_rdata, "rs-ws-03-2.rds"))

results <- readRDS(paste0(path_rdata, "rs-ws-03-2.RDS"))