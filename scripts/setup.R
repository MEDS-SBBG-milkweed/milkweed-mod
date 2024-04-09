##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##----------------------------- MILKWEEDMOD SETUP-------------------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


##~~~~~~~~~~~~~~~~~~
##  ~ Packages  ----
##~~~~~~~~~~~~~~~~~~
library(tidyverse)
library(raster)
library(terra)
library(sf)


##~~~~~~~~~~~~~~~~~~~~~~
##  ~ Cleaned Data  ----
##~~~~~~~~~~~~~~~~~~~~~~

#.............................Milkweed Points....................

californica_points <- read_csv("~/../../capstone/milkweedmod/data/clean_data/milkweed_points/californica_points.csv")
erosa_points <- read_csv("~/../../capstone/milkweedmod/data/clean_data/milkweed_points/erosa_points.csv")
eriocarpa_points <- read_csv("~/../../capstone/milkweedmod/data/clean_data/milkweed_points/eriocarpa_points.csv")
vestita_points <- read_csv("~/../../capstone/milkweedmod/data/clean_data/milkweed_points/vestita_points.csv")

#.............................Maxent.............................

# Stacked rasters
envs_Ac <- brick(here::here(("~/../../capstone/milkweedmod/data/clean_data/env_rasters/env_stack.tif")))
envs_north <- brick(here::here(("~/../../capstone/milkweedmod/data/clean_data/env_rasters/env_stack_north.tif")))

# Individual Layers
bioclim <- brick(here::here("~/../../capstone/milkweedmod/data/bioclim/wallace_bioclim.tif"))
canopy <- raster(here::here("~/../../capstone/milkweedmod/data/canopy_cover/canopy_cover_cleaned.tif"))
slope <- raster(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_slope.tif"))
aspect <- raster(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_aspect.tif"))

#.............................LPNF Boundary.............................

lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary/lpnf_boundary.shp"))

lpnf_north <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary_north/lpnf_boundary_north.shp")) 
# %>%
#   st_buffer(dist = 1000) # add buffer if necessary
lpnf_south <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary_south/lpnf_boundary_south.shp"))
# %>%
#   st_buffer(dist = 1000) # add buffer if necessary


#.............................Trails and Roads.............................

