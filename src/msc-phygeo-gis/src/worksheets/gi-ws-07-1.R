# gi-ws-07-1
# MOC - Data Analysis (T. Nauss, C. Reudenbach)
# API calls

# Set path ---------------------------------------------------------------------
if(Sys.info()["sysname"] == "Windows"){
  source("D:/active/moc/msc-phygeo-gis/scripts/msc-phygeo-gis/src/functions/set_environment.R")
} else {
  filepath_base <- "/media/permanent/active/moc/msc-phygeo-gis/scripts/msc-phygeo-gis/src/functions/set_environment.R"
}

cmd <- paste0(saga_cmd, "sim_hydrology 1 ",
              "-DEM ", path_hydrology, '"las_dtm_01m.tif [no sinks].sgrd" ',
              "-FLOW ", path_hydrology, "kinwave_runoff.sgrd ",
              "-GAUGES ", path_hydrology, "gauge/gauge.shp ", 
              "-GAUGES_FLOW ", path_hydrology, "gauge_flow_01.txt ",
              "-TIME_SPAN 24 ",
              "-TIME_STEP 1.0 ",
              "-PRECIP 0")
system(cmd)
