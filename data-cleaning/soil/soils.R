library(sf)
library(soilDB)

here("~/../../capstone/milkweedmod/data/milkweed_polygon_data/")

soil_db <- sf::st_read("~/../../capstone/milkweedmod/data/soil_data/gNATSGO_CA/gNATSGO_CA.gdb", layer = "MapunitRaster_10m")

#st_layers("~/../../capstone/milkweedmod/data/soil_data/gNATSGO_CA/gNATSGO_CA.gdb")

st_crs(soil_db)

plot(soil_db$FOOTPRINT)


a <- st_bbox(
  c(xmin = -119.93, xmax = -118.94, ymin = 34.95, ymax = 34.45), 
  crs = st_crs(4326)
)



# fetch gSSURGO map unit keys at native resolution (30m)
mu <- mukey.wcs(aoi = a, db = 'gssurgo')

plot(
  mu, 
  main = 'gSSURGO map unit keys',
  sub = 'Albers Equal Area Projection',
  axes = FALSE, 
  legend = FALSE
)




p <- SDA_spatialQuery(mu, what = 'mupolygon', geomIntersection = TRUE)
p <- project(p, crs(mu))
plot(mu,
     main = 'gSSURGO Grid (WCS)\nSSURGO Polygons (SDA)',
     axes = FALSE,
     legend = FALSE)
plot(p, add = TRUE, border = 'white')
mtext('CONUS Albers Equal Area Projection (EPSG:5070)', side = 1, line = 1)
