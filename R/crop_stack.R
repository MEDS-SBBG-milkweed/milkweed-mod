library(tidyverse)
library(raster)
library(terra)
library(sf)
library(here)

# Read in bioclim, canopy, slope, and aspect data
bioclim <- brick(here::here("~/../../capstone/milkweedmod/clean_data/bioclim/wallace_bioclim.tif"))
canopy <- raster(here::here("~/../../capstone/milkweedmod/clean_data/canopy_cover/canopy_cover_cleaned.tif"))
northness <- raster(here::here("~/../../capstone/milkweedmod/clean_data/dem/northness.tif"))
eastness <- raster(here::here("~/../../capstone/milkweedmod/clean_data/dem/eastness.tif"))

# California National Forest boundaries
lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary/lpnf_boundary.shp"))
lpnf_north_buffer <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_north/lpnf_boundary_north.shp")) %>%
  st_buffer(dist = 1000)
lpnf_south_buffer <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_south/lpnf_boundary_south.shp")) %>%
  st_buffer(dist = 1000)

# Resample
bioclim_resample <- resample(bioclim, canopy)
northness_resample <- resample(northness, canopy)
eastness_resample <- resample(eastness, canopy)

# Mask
canopy_mask <- mask(canopy, bioclim_resample)
northness_mask <- mask(northness_resample, bioclim_resample)
eastness_mask <- mask(eastness_resample, bioclim_resample)

# Stack
envs_Ac <- raster::stack(bioclim_resample, canopy_mask, northness_mask, eastness_mask)
crs(envs_Ac) <- "EPSG:4326"


# Write rasters
# writeRaster(envs_Ac, here::here(("~/../../capstone/milkweedmod/clean_data/sdm_env_stack/env_stack.tif")), overwrite=TRUE)
