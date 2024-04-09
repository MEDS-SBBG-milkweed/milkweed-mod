library(tidyverse)
library(raster)
library(terra)
library(sf)

# Read in bioclim, canopy, slope, and aspect data
bioclim <- brick(here::here("~/../../capstone/milkweedmod/data/bioclim/wallace_bioclim.tif"))
canopy <- raster(here::here("~/../../capstone/milkweedmod/data/canopy_cover/canopy_cover_cleaned.tif"))
slope <- raster(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_slope.tif"))
aspect <- raster(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_aspect.tif"))
northness <- cos(aspect * (180 / pi)) * sin(slope * (180 / pi)) 
eastness <- sin(aspect * (180 / pi)) * sin(slope * (180 / pi))

# California National Forest boundaries
lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary/lpnf_boundary.shp"))
lpnf_north <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary_north/lpnf_boundary_north.shp")) %>%
  st_buffer(dist = 1000)

# Resample
bioclim_resample <- resample(bioclim, canopy)
aspect_resample <- resample(aspect, canopy)
slope_resample <- resample(slope, canopy)
northness_resample <- resample(northness, canopy)
eastness_resample <- resample(eastness, canopy)

# Mask
canopy_mask <- mask(canopy, bioclim_resample)
aspect_mask <- mask(aspect_resample, bioclim_resample)
slope_mask <- mask(slope_resample, bioclim_resample)
northness_mask <- mask(northness_resample, bioclim_resample)
eastness_mask <- mask(eastness_resample, bioclim_resample)

# Stack
envs_Ac <- raster::stack(bioclim_resample, canopy_mask, aspect_mask, slope_mask)
envs_Ac2 <- raster::stack(bioclim_resample, canopy_mask, northness_mask, eastness_mask)
crs(envs_Ac) <- "EPSG:4326"
crs(envs_Ac2) <- "EPSG:4326"

# Crop for northern section
envs_north <- crop(envs_Ac, lpnf_north)
envs_north2 <- crop(envs_Ac2, lpnf_north)


# Write rasters
# writeRaster(envs_Ac2, here::here(("~/../../capstone/milkweedmod/data/clean_data/env_rasters/env_stack2.tif")))
# writeRaster(envs_north, here::here(("~/../../capstone/milkweedmod/data/clean_data/env_rasters/env_stack_north.tif")))
