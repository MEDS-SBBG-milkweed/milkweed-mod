##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##------------------- MILKWEED POINTS CLEANING AND EXPORT-----------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Load packages
library(tidyverse)
library(sf)

# Read in poygon data
milkweed_data_raw <- st_read(here::here("~/../../capstone/milkweedmod/raw_data/milkweed_polygon_data/"))

# Filter and project
milkweed_presence <- milkweed_data_raw |> 
  janitor::clean_names() |> 
  filter(milkweed_p != "no")  %>%
  st_transform("EPSG:4326") 

##~~~~~~~~~~~~~~~~~~~~~
##  ~ Californica  ----
##~~~~~~~~~~~~~~~~~~~~~

# remove "No" observations
californica <- milkweed_presence %>%
  filter(milkweed_sp == "Asclepias californica") %>%
  dplyr::select(milkweed_sp)

# make points
multi_p_cali <- st_cast(californica, "MULTIPOINT")
cali_points <- multi_p_cali  %>% st_cast("POINT")

cali_points <- cali_points %>%
  st_coordinates() %>%
  data.frame() %>%
  mutate(scientific_name = "Asclepias californica") %>%
  mutate(occID = row_number()) %>%
  rename(longitude = X,
         latitude = Y)


##~~~~~~~~~~~~~~~~~~~~~
##  ~ Eriocarpa  ----
##~~~~~~~~~~~~~~~~~~~~~

# remove "No" observations
eriocarpa <- milkweed_presence %>%
  filter(milkweed_sp == "Asclepias eriocarpa") %>%
  dplyr::select(milkweed_sp)

# make points
multi_p_eriocarpa <- st_cast(eriocarpa, "MULTIPOINT")
eriocarpa_points <- multi_p_eriocarpa  %>% st_cast("POINT")

eriocarpa_points <- eriocarpa_points %>%
  st_coordinates() %>%
  data.frame() %>%
  mutate(scientific_name = "Asclepias eriocarpa") %>%
  mutate(occID = row_number()) %>%
  rename(longitude = X,
         latitude = Y)


##~~~~~~~~~~~~~~~~~~~~~
##  ~ Erosa  ----
##~~~~~~~~~~~~~~~~~~~~~

# remove "No" observations
erosa <- milkweed_presence %>%
  filter(milkweed_sp == "Asclepias erosa") %>%
  dplyr::select(milkweed_sp)

# make points
multi_p_erosa <- st_cast(erosa, "MULTIPOINT")
erosa_points <- multi_p_erosa  %>% st_cast("POINT")

erosa_points <- erosa_points %>%
  st_coordinates() %>%
  data.frame() %>%
  mutate(scientific_name = "Asclepias erosa") %>%
  mutate(occID = row_number()) %>%
  rename(longitude = X,
         latitude = Y)


##~~~~~~~~~~~~~~~~~~~~~
##  ~ Vestita  ----
##~~~~~~~~~~~~~~~~~~~~~

# remove "No" observations
vestita <- milkweed_presence %>%
  filter(milkweed_sp == "Asclepias vestita") %>%
  dplyr::select(milkweed_sp)

# make points
multi_p_vestita <- st_cast(vestita, "MULTIPOINT")
vestita_points <- multi_p_vestita  %>% st_cast("POINT")

vestita_points <- vestita_points %>%
  st_coordinates() %>%
  data.frame() %>%
  mutate(scientific_name = "Asclepias vestita") %>%
  mutate(occID = row_number()) %>%
  rename(longitude = X,
         latitude = Y)


##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                              Export to Data Folder                            ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# write_csv(cali_points, "~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/californica_points.csv")
# write_csv(erosa_points, "~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/erosa_points.csv")
# write_csv(eriocarpa_points, "~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/eriocarpa_points.csv")
# write_csv(vestita_points, "~/../../capstone/milkweedmod/clean_data/milkweed_data/sdm_milkweed_points/vestita_points.csv")






