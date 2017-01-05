# rs-ws-03-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# Check radiometric image alignment

# Set environment --------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-ui/scripts/msc-phygeo-ui/src/functions/set_environment.R")
} else {
  source("/media/permanent/active/moc/msc-ui/scripts/msc-phygeo-ui/src/functions/set_environment.R")
}


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
ngbs <- ngb_aerials(aerial_files)


ngbs_values <- lapply(seq(length(ngbs)), function(i){
  
  act_file <- names(ngbs)[i]
  ngb_files <- ngbs[[i]]
  
  act_stack <- stack(act_file)
  
  if(is.na(ngb_files[1])){
    nb <- NA
  } else {
    nb <- data.frame(act_stack[1:2, ],
                     stack(ngb_files[1])[9999:10000, ])
  }
  
  if(is.na(ngb_files[2])){
    eb <- NA
  } else {
    eb <- data.frame(act_stack[, 9999:10000],
                     stack(ngb_files[2])[, 1:2])
  }
 
  if(is.na(ngb_files[3])){
    sb <- NA
  } else {
    sb <- data.frame(act_stack[9999:10000, ],
                     stack(ngb_files[3])[1:2, ])
  }
  
  if(is.na(ngb_files[4])){
    wb <- NA
  } else {
    wb <- data.frame(act_stack[, 1:2],
                     stack(ngb_files[4])[, 9999:10000])
  }
  
  act_ngb <- list(NORTH = nb,
                  EAST = eb,
                  SOUTH = sb,
                  WEST = wb)
  return(act_ngb)
})

saveRDS(ngbs_values, paste0(path_rdata, "ngbs_values.rds"))


summary(s1s3v_div)
hist(s1s3v)
