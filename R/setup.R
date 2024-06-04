##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##----------------------------- MILKWEEDMOD SDM SETUP---------------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Define base directory file path
base_dir <- here::here("~/Library/CloudStorage/Box-Box/MEDS-SBBG-milkweed")

##~~~~~~~~~~~~~~~~~~
##  ~ Packages  ----
##~~~~~~~~~~~~~~~~~~
library(tidyverse)
library(raster)
library(terra)
library(sf)
library(here)


##~~~~~~~~~~~~~~~~~~~~~~
##  ~ Cleaned Data  ----
##~~~~~~~~~~~~~~~~~~~~~~

#.............................Milkweed Points....................

californica_points <- read_csv(here(base_dir, "clean_data", "milkweed_data", "sdm_milkweed_points", "californica_points.csv"))
erosa_points <- read_csv(here(base_dir, "clean_data", "milkweed_data", "sdm_milkweed_points", "erosa_points.csv"))
eriocarpa_points <- read_csv(here(base_dir, "clean_data", "milkweed_data", "sdm_milkweed_points", "eriocarpa_points.csv"))
vestita_points <- read_csv(here(base_dir, "clean_data", "milkweed_data", "sdm_milkweed_points", "vestita_points.csv"))

#.............................Maxent.............................

# Stacked rasters
envs_Ac <- brick(here(base_dir, "clean_data", "sdm_env_stack", "env_stack.tif"))

#.............................LPNF Boundary.............................

lpnf_boundary <- st_read(here(base_dir, "clean_data", "lpnf_boundary", "lpnf_boundary", "lpnf_boundary.shp"))
lpnf_boundary_buffered <- st_read(here(base_dir, "clean_data", "lpnf_boundary", "lpnf_boundary_buffered", "lpnf_boundary_buffered.shp"))
lpnf_north <- st_read(here(base_dir, "clean_data", "lpnf_boundary", "lpnf_boundary_north", "lpnf_boundary_north.shp")) 
lpnf_north_buffered <- st_read(here(base_dir, "clean_data", "lpnf_boundary", "lpnf_boundary_north_buffered", "lpnf_boundary_north_buffered.shp"))
lpnf_south <- st_read(here(base_dir, "clean_data", "lpnf_boundary", "lpnf_boundary_south", "lpnf_boundary_south.shp")) 
lpnf_south_buffered <- st_read(here(base_dir, "clean_data", "lpnf_boundary", "lpnf_boundary_south_buffered", "lpnf_boundary_south_buffered.shp")) 
