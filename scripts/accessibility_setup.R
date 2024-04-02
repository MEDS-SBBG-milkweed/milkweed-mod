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

lpnf_boundary <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary/lpnf_boundary.shp"))
lpnf_north <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary_north/lpnf_boundary_north.shp")) 
# %>%
#   st_buffer(dist = 1000) # add buffer if necessary
lpnf_south <- st_read(here("~/../../capstone/milkweedmod/data/lpnf_boundary_data/lpnf_boundary_south/lpnf_boundary_south.shp"))
# %>%
#   st_buffer(dist = 1000) # add buffer if necessary

#.............................Canopy Cover.............................

canopy_cover <- rast(here("~/../../capstone/milkweedmod/data/clean_data/canopy_cover_cleaned.tif"))

#.................................Slope.................................

slope <- rast(here::here("~/../../capstone/milkweedmod/data/dem/lpnf_slope.tif"))

#.............................Land Ownership.............................

lpnf_ownership <- st_read(here("~/../../capstone/milkweedmod/data/clean_data/lpnf_land_ownership/lpnf_land_ownership.shp"))

#.............................Trails & Roads.............................

