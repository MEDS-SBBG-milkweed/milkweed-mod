
raster <- terra::rast(here::here("~/../../capstone/milkweedmod/data/models/allpoints_bioclim_canopy_dem.tif")
)
lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary/lpnf_boundary.shp")) %>%
  st_buffer(dist = 800)

rast_mult <- (raster * 0.734) + 0.123

rast_mult[rast_mult[] < 0.8 ] = NA 

plot(rast_mult)

library(leaflet)
source("scripts/addLegend_decreasing.R")


mapPredVals_Ac <- getRasterVals(rast_mult) # change for different types

colors <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
legendPal <- colorBin(colors, mapPredVals_Ac, na.color = 'transparent', bins = 5)
rasPal <- colorBin(colors,mapPredVals_Ac, na.color = 'transparent', bins = 5)

leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
  addRasterImage(rast_mult, colors = rasPal, opacity = 0.7) %>%
  addPolygons(data = lpnf_boundary,
              fill = FALSE,
              color = "black",
              weight = 2)  %>%
  addLegend_decreasing("bottomleft", pal = legendPal, values = mapPredVals_Ac,
                       labFormat = reverseLabel(), decreasing = TRUE,
                       title = "")

milkweed_data_raw <- st_read(here::here("~/../../capstone/milkweedmod/data/milkweed_polygon_data/"))
# remove "No" observations
milkweed_presence <- milkweed_data_raw |> 
  janitor::clean_names() |> 
  filter(milkweed_p != "no")  %>%
  st_transform("EPSG:4326") %>%
  filter(milkweed_sp == "Asclepias californica") %>%
  dplyr::select(milkweed_sp)

# make points
multi.p <- st_cast(milkweed_presence, "MULTIPOINT")
my_points <- multi.p  %>% st_cast("POINT")

milkweed_points <- my_points %>%
  st_coordinates() %>%
  data.frame() %>%
  mutate(scientific_name = "Asclepias californica") %>%
  mutate(occID = row_number()) %>%
  rename(longitude = X,
         latitude = Y) %>%
  select(latitude, longitude)

mapPredVals_Ac %>%
  data.frame() %>%
  rename("site score" = 1) %>%
  mutate(`milkweed species` = "A. californica") %>%
  head(274) %>%
  cbind(milkweed_points) %>%
  head(4) %>%
  gt::gt()

  