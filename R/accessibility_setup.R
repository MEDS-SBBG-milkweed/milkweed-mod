##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##------------------- MILKWEEDMOD ACCESSIBILITY INDEX SETUP---------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

##~~~~~~~~~~~~~~~~~~
##  ~ Packages  ----
##~~~~~~~~~~~~~~~~~~
library(tidyverse)
library(raster)
library(terra)
library(stars)
library(sf)
library(here)
library(leaflet)


##~~~~~~~~~~~~~~~~~~~~~~
##  ~ Cleaned Data  ----
##~~~~~~~~~~~~~~~~~~~~~~

#.............................LPNF Boundary.............................

lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary/lpnf_boundary.shp"),
                         quiet = TRUE)
lpnf_north <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_north/lpnf_boundary_north.shp"),
                      quiet = TRUE) 
lpnf_south <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_south/lpnf_boundary_south.shp"),
                      quiet = TRUE)
lpnf_boundary_buffered <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_buffered/lpnf_boundary_buffered.shp"),
                                  quiet = TRUE)
lpnf_boundary_north_buffered <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_north_buffered/lpnf_boundary_north_buffered.shp"),
                                        quiet = TRUE)
lpnf_boundary_south_buffered <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_boundary/lpnf_boundary_south_buffered/lpnf_boundary_south_buffered.shp"),
                                        quiet = TRUE)

#.............................Canopy Cover.............................

canopy_cover <- rast(here("~/../../capstone/milkweedmod/clean_data/canopy_cover/canopy_cover_cleaned.tif"))

#.................................Slope.................................

slope <- rast(here("~/../../capstone/milkweedmod/clean_data/dem/lpnf_slope.tif")) %>% 
  project("EPSG:4326")

#.............................Land Ownership.............................

lpnf_ownership <- st_read(here("~/../../capstone/milkweedmod/clean_data/lpnf_land_ownership/lpnf_land_ownership.shp"),
                          quiet = TRUE)

#..........................Distance from Roads...........................

roads <- rast(here("~/../../capstone/milkweedmod/clean_data/site_accessibility/roads_distance_raster.tif"))

#..........................Distance from Trails...........................

trails <- rast(here("~/../../capstone/milkweedmod/clean_data/site_accessibility/trails_distance_raster.tif"))

#............................Template Raster..............................
temp_rast_stars <- read_stars(here("~/../../capstone/milkweedmod/clean_data/site_accessibility/template_raster.tif"))

temp_rast <- rast(temp_rast_stars)