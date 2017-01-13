# rs-ws-05-2
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Merging training areas

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


# Merge shape files ------------------------------------------------------------
# Read names of shape files
shp_names <- list.files(path_landcover_training_areas, 
                        pattern = glob2rx("*.shp"), full.names = TRUE)

# Put shapes in a list and adjust geometry ids
shift <- 0
shps <- list()
for(s in seq(length(shp_names))){
  act_shps <- readOGR(shp_names[s], ogrListLayers(shp_names[s]))
  shps[[s]] <- spChFIDs(act_shps, as.character(seq(nrow(act_shps)) + shift))
  shift <- shift + nrow(act_shps)
}

# rownames(as(shps[[1]], "data.frame"))

# Remove non-standard columns (if necessary)
shps[[1]]@data$merge_id <- NULL

# Combine shapes
shps_cmb <- do.call("rbind", shps)

# Recode values
ids_old <- unique(shps_cmb@data$ID)
ids_repl <- paste(ids_old, ids_new, sep = "=", collapse = ";")
shps_cmb@data$ID <- recode(shps_cmb@data$ID, ids_repl)

# Write shape file
writeOGR(shps_cmb, paste0(path_landcover_training_areas, "muf_training"),
         "muf_training", driver = "ESRI Shapefile", overwrite = TRUE)

