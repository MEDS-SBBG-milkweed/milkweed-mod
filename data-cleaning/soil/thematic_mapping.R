library(sf)
library(soilDB)

# example fron https://cran.r-project.org/web/packages/soilDB/vignettes/wcs-ssurgo.html

# make a bounding box and assign a CRS (4326: GCS, WGS84)
a <- st_bbox(
  c(xmin = -119.93, xmax = -119.52, ymin = 34.95, ymax = 34.59), 
  crs = st_crs(4326)
)

# convert bbox to sf geometry
a <- st_as_sfc(a)

# fetch gSSURGO map unit keys at native resolution (~30m)
mu <- mukey.wcs(aoi = a, db = 'gssurgo')

# copy example grid
mu2 <- mu

# optionally use convenience function:
  # * returns all fields from muaggatt table
  # * along with map unit name
  # tab <- get_SDA_muaggatt(mukeys = as.numeric(rat$mukey), query_string = TRUE)

# extract RAT for thematic mapping
rat <- cats(mu2)[[1]]

# find layer names
# https://www.nrcs.usda.gov/sites/default/files/2022-08/SSURGO-Metadata-Table-Column-Descriptions-Report.pdf
.sql <- paste0(
  "SELECT mukey, aws050wta, aws0100wta FROM muaggatt WHERE mukey IN ",
  format_SQL_in_statement(as.numeric(rat$mukey))
)

# run query, result is a data.frame
tab <- SDA_query(.sql)

# check
head(tab)

# set raster categories
levels(mu2) <- tab

# convert grid + RAT -> stack of property grids
aws <- catalyze(mu2)

# plot, set a common range [0, 20] for both layers
plot(
  aws,
  axes = FALSE,
  cex.main = 0.7,
  main = c(
    'Plant Available Water Storage (cm)\nWeighted Mean over Components, 0-50cm',
    'Plant Available Water Storage (cm)\nWeighted Mean over Components, 0-100cm'
  ),
  range = c(0, 20)
)
