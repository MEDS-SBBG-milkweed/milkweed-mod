library(tidyverse)
library(raster)
library(terra)
library(sf)

# Read in bioclim, canopy, slope, and aspect data
bioclim <- brick(here::here("~/../../capstone/milkweedmod/data/bioclim/wallace_bioclim.tif"))
canopy <- raster(here::here("~/../../capstone/milkweedmod/data/canopy_cover/canopy_cover_cleaned.tif"))
slope <- raster(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_slope.tif"))
aspect <- raster(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_aspect.tif"))

# California National Forest boundaries
lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary/lpnf_boundary.shp"))
lpnf_north <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary_north/lpnf_boundary_north.shp")) %>%
  st_buffer(dist = 1000)

# Resample
bioclim_resample <- resample(bioclim, canopy)
aspect_resample <- resample(aspect, canopy)
slope_resample <- resample(slope, canopy)

# Mask
canopy_mask <- mask(canopy, bioclim_resample)
aspect_mask <- mask(aspect_resample, bioclim_resample)
slope_mask <- mask(slope_resample, bioclim_resample)

# Stack
envs_Ac <- raster::stack(bioclim_resample, canopy_mask, aspect_mask, slope_mask)
crs(envs_Ac) <- "EPSG:4326"

# Crop for northern section
envs_north <- crop(envs_Ac, lpnf_north)


# Write rasters
# writeRaster(envs_Ac, here::here(("~/../../capstone/milkweedmod/data/clean_data/env_rasters/env_stack.tif")))
# writeRaster(envs_north, here::here(("~/../../capstone/milkweedmod/data/clean_data/env_rasters/env_stack_north.tif")))
