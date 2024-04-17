##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##----------------------------- MILKWEEDMOD SDM SETUP---------------------------
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

californica_points <- read_csv("~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/californica_points.csv")
erosa_points <- read_csv("~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/erosa_points.csv")
eriocarpa_points <- read_csv("~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/eriocarpa_points.csv")
vestita_points <- read_csv("~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/vestita_points.csv")

#.............................Maxent.............................

# Stacked rasters
#envs_Ac <- brick(here::here(("~/../../capstone/milkweedmod/clean_data/sdm_env_stack/env_stack.tif")))
envs_Ac2 <- brick(here::here(("~/../../capstone/milkweedmod/clean_data/sdm_env_stack/env_stack2.tif")))
#envs_north <- brick(here::here(("~/../../capstone/milkweedmod/clean_data/sdm_env_stack/env_stack_north.tif")))
#envs_north2 <- brick(here::here(("~/../../capstone/milkweedmod/clean_data/sdm_env_stack/env_stack_north2.tif")))

# Individual Layers
# bioclim <- brick(here::here("~/../../capstone/milkweedmod/clean_data/bioclim/wallace_bioclim.tif"))
# canopy <- raster(here::here("~/../../capstone/milkweedmod/clean_data/canopy_cover/canopy_cover_cleaned.tif"))
# slope <- raster(here::here("~/../../capstone/milkweedmod/clean_data/dem/lpnf_slope.tif"))
# aspect <- raster(here::here("~/../../capstone/milkweedmod/clean_data/dem/lpnf_aspect.tif"))

#.............................LPNF Boundary.............................

lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary/lpnf_boundary.shp"))
lpnf_boundary_buffered <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_buffered/lpnf_boundary_buffered.shp"))
lpnf_north <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_north/lpnf_boundary_north.shp")) 
lpnf_north_buffered <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_north_buffered/lpnf_boundary_north_buffered.shp"))
lpnf_south <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_south/lpnf_boundary_south.shp")) 
# %>%
#   st_buffer(dist = 500)
lpnf_south_buffered <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_south_buffered/lpnf_boundary_south_buffered.shp"))
