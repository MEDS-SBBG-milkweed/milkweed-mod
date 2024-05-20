library(tidyverse)
library(raster)
library(terra)
library(sf)
library(here)

# Read in bioclim, canopy, slope, and aspect data
bioclim <- brick(here::here("~/../../capstone/milkweedmod/clean_data/bioclim/wallace_bioclim.tif"))
canopy <- raster(here::here("~/../../capstone/milkweedmod/clean_data/canopy_cover/canopy_cover_cleaned.tif"))
names(canopy) <- "canopy_cover_percent"
northness <- raster(here::here("~/../../capstone/milkweedmod/clean_data/dem/northness.tif"))
eastness <- raster(here::here("~/../../capstone/milkweedmod/clean_data/dem/eastness.tif"))

# Resample
bioclim_resample <- resample(bioclim, canopy)
northness_resample <- resample(northness, canopy)
eastness_resample <- resample(eastness, canopy)

# Stack
envs_Ac <- stack(bioclim_resample, northness_resample, eastness_resample, canopy) %>%
  rast()
crs(envs_Ac) <- "EPSG:4326"

# Write rasters
# terra::writeRaster(envs_Ac, here::here(("~/../../capstone/milkweedmod/clean_data/sdm_env_stack/env_stack.tif")), overwrite=TRUE)
