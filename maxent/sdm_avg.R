library(here)
library(terra)
library(leaflet)
source("scripts/addLegend_decreasing.R")


vestita <- raster(here("~/../../capstone/milkweedmod/outputs/sdm_outputs/vestita_sdm.tif"))
eriocarpa <- raster(here("~/../../capstone/milkweedmod/outputs/sdm_outputs/eriocarpa_sdm.tif"))
erosa <- raster(here("~/../../capstone/milkweedmod/outputs/sdm_outputs/erosa_sdm.tif"))
californica <- raster(here("~/../../capstone/milkweedmod/outputs/sdm_outputs/californica_sdm.tif"))

lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary/lpnf_boundary.shp"))

# 
model_avg <- (vestita + eriocarpa + erosa + californica) / 4

all_species <- stack(vestita, eriocarpa, erosa, californica)

max_suitable <- max(all_species)

#Define colors and legend  
mapPredVals_Ac <- getRasterVals(max_suitable, "cloglog") # change for different types
rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
legendPal <- colorNumeric(rasCols, mapPredVals_Ac, na.color = 'transparent')
rasPal <- colorNumeric(rasCols, mapPredVals_Ac, na.color = 'transparent')

leaflet() %>% addProviderTiles(providers$Esri.WorldTerrain) %>%
  addLegend_decreasing("bottomleft", pal = legendPal, values = mapPredVals_Ac,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "<em>Asclepias sp.</em> Maximum<br> Predicted Suitability<br>") %>%
  addRasterImage(max_suitable, colors = rasPal, opacity = 0.7,
                 group = 'vis', layerId = 'mapPred', method = "ngb") %>%
  addPolygons(data = lpnf_boundary,
              fill = FALSE,
              color = "black",
              weight = 2)

#Esri.WorldTerrain


writeRaster(max_suitable, here("~/../../capstone/milkweedmod/outputs/sdm_outputs/max_suitable_sdm.tif"))

