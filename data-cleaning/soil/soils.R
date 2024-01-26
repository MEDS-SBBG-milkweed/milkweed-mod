library(sf)
library(soilDB)
library(tmap)


a <- st_bbox(
  c(xmin = -119.93, xmax = -119.52, ymin = 34.95, ymax = 34.59), 
  crs = st_crs(4326)
)

#'var' should be one of: “statsgo_pct”, “ssurgo_pct”, “om_kg_sq_m”, “caco3_kg_sq_m”, “ec_05cm”, “ec_025cm”, “cec_05cm”, “cec_025cm”, “cec_050cm”, “paws”, “paws_050cm”, “paws_025cm”, “ph_05cm”, “ph_025cm”, “ph_2550cm”, “ph_3060cm”, “clay_05cm”, “clay_025cm”, “clay_2550cm”, “clay_3060cm”, “sand_05cm”, “sand_025cm”, “sand_2550cm”, “sand_3060cm”, “silt_05cm”, “silt_025cm”, “silt_2550cm”, “silt_3060cm”, “sar”, “series_name”, “hydgrp”, “drainage_class”, “weg”, “wei”, “str”, “soilorder”, “suborder”, “greatgroup”, “texture_05cm”, “texture_025cm”, “texture_2550cm”, “lcc_irrigated”, “lcc_nonirrigated”
# https://casoilresource.lawr.ucdavis.edu/soil-properties/download.php

silt <- ISSR800.wcs(aoi = a, var = "silt_2550cm", res = 800, quiet = FALSE)

texture_05cm <- ISSR800.wcs(aoi = a, var = "texture_05cm", res = 800, quiet = FALSE)

plot(
  silt, 
  main = 'ISSR800: percent silt 25 to 50cm ',
  axes = FALSE, 
  legend = TRUE
)

plot(
  texture_05cm, 
  main = 'ISSR800: Soil Texture 0 to 5cm ',
  axes = FALSE, 
  legend = TRUE
)

milkweed_path <- here("~/../../capstone/milkweedmod/data/milkweed_polygon_data/")
milkweed_data_raw <- st_read(milkweed_path) %>%
  st_transform(.,"EPSG:5070")

tmap_mode("view")

tm_shape(texture_05cm) +
  tm_raster(title = "ISSR800: Soil Texture 0 to 5cm") +
  tm_shape(milkweed_data_raw) +
  tm_polygons(fill_alpha = 1, fill = "red", color = "red") +
  tm_layout(legend.title.size = 1,
            legend.text.size = 0.6,
            legend.position = c("left","top"),
            legend.bg.color = "white",
            legend.digits = 5,
            legend.bg.alpha = 0.6,
  legend.height =17)



z <- mukey.wcs(a, db = 'gssurgo', res = 30)
plot(z, main = attr(z, 'layer name'))
