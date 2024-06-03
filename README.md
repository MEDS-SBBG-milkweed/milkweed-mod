<h1 align="center">

MilkweedMod

</h1>

<h2 align="center">

**Identifying Priority Survey Sites for Early-Season Milkweed Conservation**

</h2>

<h2 align="center">

<img src = "https://github.com/MEDS-SBBG-milkweed/.github/assets/98177666/b98e752a-194c-4e54-8623-15ef18f8409b" alt="MilkweedMod capstone group hexsticker. Dark green background with a white outline of California, filled in with illustrated milkweed plants and an orange monarch butterfly accompanying the text Milkweed Mod" width="300">

<h2 align="center">

**milkweed-mod**

</h2>


## Table of Contents

[Project Description](#project-description)


[Folder Descriptions](#folder-description)


[Methods](#methods)


[Data](#data-sources)


[Repository Structure](#repository-structure)


[Technical Documentation](#technical-documentation)


[Disclaimers](#disclaimers)


[Authors](#authors)


[Client](#client)



## Project Description

To identify high-priority sites for the SBBG to visit in their upcoming surveys of early-season milkweed in the LPNF, we wanted to identify locations that were both highly suitable for each species of milkweed and highly physically accessible to enable the garden team to visit many locations efficiently. 


This repository contains all scripts and notebooks used in the data processing, species distribution models (SDM) and habitat suitability map development, survey site accessibility index development, and survey site priority index and map development for this capstone project.


## Folder Descriptions

**R**: 

This folder contains functions used throughout the project: 
- `addLegend_decreasing.R` for reversing a leaflet legend scale
- `milkweed_maxent.R` for easily running a maximum entropy species distribution model
- `rescale_raster.R` for rescaling rasters to a scale of 0 to 1 based on the minimum and maximum values

As well as setup scripts that load all necessary data:
- `accessibility_setup.R` loads all data needed for building the survey site accessibility index
- `setup.R` loads all data needed for species distribution modeling to build milkweed habitat suitability maps.


**data_cleaning**:

This folder contains all of the notebooks and scripts used to clean and process all of the raw data to prepare for use in building milkweed habitat suitability maps and survey site accessibility index. All code found in this directory should not be run unless new, raw data is included in the project.

**legends**:

This folder contains a notebook that creates infographic-style legends for the milkweed habitat suitability maps, survey site accessibility index, and survey site priority index. These legends are used in the Milkweed Site Finder dashboard.

**maxent**:

This folder contains notebooks that create milkweed habitat suitability maps for each species of early-season milkweed using MaxEnt species distribution modeling.

**outputs**:

This folder contains all outputs produced in the project. The `dashboard` subfolder contains all outputs displayed on the dashboard including milkweed habitat suitability maps, survey site accessibility index (and the individual rescaled layers used to build it), survey site priority indices, milkweed species occurrence points, and infographic legends. The `figs` subfolder contains images of all outputs.

**priority_sites**:

This folder contains the notebooks that create the survey site priority index for each species of early-season milkweed. 

**site_accessibility**:

This folder contains the notebooks used in the development of the survey site accessibility index. This includes the notebook in which distances from trails and roads are calculated, as well as a notebook in which all layers used in the creation of this novel index are rescaled to a scale of 0 to 1. 

**walkthroughs**:

This folder contains a notebook with instructions for updating habitat suitability maps by incorporating new data in species distribution modeling, updating trails and roads data by adding or removing trails or roads based on open/closed status or name and subsequently updating the survey site accessibility indices, and ultimately updating the survey site priority indices.


## Methods

This project was developed in the programming language R, in the integrated development environment, RStudio. All packages and versions used are in the `session_info.txt` file.


**Habitat suitability map.** To identify locations in the forest that are highly suitable for milkweed, we created a habitat suitability map using a maximum entropy (MaxEnt) species distribution modeling approach. This component was created using milkweed occurrence data from the SBBG’s field survey efforts from 2023 and publicly accessible environmental data. After preparing the data, all environmental layers were resampled and aggregated into a raster stack. We input milkweed occurrence points along with the environmental layer raster stack, and the model outputs a map of predicted milkweed habitat suitability in the LPNF. 

<img src = "https://github.com/MEDS-SBBG-milkweed/milkweed-mod/blob/main/outputs/figs/A_californica_sdm.png" alt="Habitat suitability map for Asclepias californica within the Los Padres National Forest" width="200">

**Survey site accessibility map.** To identify how physically accessible each location in the LPNF is, we developed a novel survey site accessibility index. We created this based on factors that we and our client deemed important in measuring physical accessibility, including distance from trails and roads, slope, vegetation density, and land ownership status. The distance from trails and roads, slope, and vegetation density data layers were rescaled to a scale of 0 (lowest relative accessibility) to 1 (highest relative accessibility). The land ownership layer was used as a mask where a value of 1 indicates public land and a value of 0 indicates private land. All of the layers were then multiplied together to create a final map of site accessibility throughout the LPNF on a scale of 0 to 1.

**Survey site priority index.** Finally, to identify high-priority survey site locations, the outputs of the habitat suitability maps and the survey site accessibility index were multiplied to create a survey site priority index. As both factors have scales from 0 to 1, with 0 being the lowest suitability and lowest accessibility and 1 being the highest suitability and highest accessibility, the resultant priority index was also scaled such that 0 indicates lowest priority and 1 indicates highest priority. 

**Interactive web dashboard.** All of this information was incorporated in an interactive format as a tool to aid the SBBG staff in survey planning. A data table displaying the relative priority for each species at each location, along with the accessibility score for that location and the visit status (whether or not the SBBG has already visited a given location in previous survey efforts) are all displayed in a data table on the interactive web dashboard. See [milkweed-site-finder](https://github.com/MEDS-SBBG-milkweed/milkweed-site-finder) for more information. 


## Data Sources


---------------------------------------------------------------------------------------------------------------

**Bioclimatic Data**

**Brief description:** Historical climate data -- 19 bioclimatic variables to represent annual trends, seasonality, extreme/limiting environmental factors based on monthly temperature and rainfall data (.tif)

**How it was accessed: wallace::envs_worldclim()**, which utilizes **raster::getData()** 

**Use:** This data was used in the development of the milkweed habitat suitability maps, which were used to create the survey site priority index. This data accessed and initially processed in the following script:

[data_cleaning/bioclim/bioclim.R](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/blob/main/data_cleaning/bioclim/bioclim.R)

**Units:** Spatial Reference: WGS 1984 (EPSG 4326)

**Citation:** Fick, S.E. and R.J. Hijmans. (2017). WorldClim 2: new 1 km spatial resolution climate surfaces for global land areas. International Journal of Climatology 37 (12): 4302-4315.

<https://www.worldclim.org/data/worldclim21.html> 

**Licenses:** The data are freely available for academic use and other non-commercial use. Redistribution or commercial use is not allowed without prior permission. Using the data to create maps for publishing of academic research articles is allowed.


---------------------------------------------------------------------------------------------------------------

**California Multi-Source Land Ownership:**

**Brief description:** Classification of land ownership, excluding lands under private ownership, in California (.shp)

**How it was accessed:** Downloaded the \"California Land Ownership\" feature layer from California State Geoportal as a shapefile

**Use:** This data was used in the development of the survey site accessibility index, which was used to create the survey site priority index. This data was initially read in and processed in the following notebook: 

[data_cleaning/land_ownership/land_ownership.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/tree/main/data_cleaning/land_ownership)

**Units:** Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:**

California Department of Forestry and Fire Protection; California State Geoportal, hosted on CAL FIRE Portal (via gis.data.ca.gov) 

<https://gis.data.ca.gov/datasets/CALFIRE-Forestry::california-land-ownership/about> 

**Licenses:**

The State of California and the Department of Forestry and Fire Protection make no representations or warranties regarding the accuracy of data or maps. Neither the State nor the Department shall be liable under any circumstances for any direct, special, incidental, or consequential damages with respect to any claim by any user or third party on account of, or arising from, the use of data or maps. For more information about this product, date, or terms of use, contact calfire.egis\@fire.ca.gov.

---------------------------------------------------------------------------------------------------------------

**Canopy Cover:**

**Brief description:** Horizontal cover fraction occupied by tree canopies (.tif)

**How it was accessed:** Downloaded from the California Forest Observatory website, selected \"Canopy Cover\" from available datasets to download. If counties need to be selected please select Kern County, Monterey County, San Luis Obispo County, and Ventura County

**Use:** This data was used in the development of the milkweed habitat suitability maps and survey site accessibility index, which were used to create the survey site priority index. This data was initially read in and processed in the following notebook:

[data_cleaning/canopy_cover/canopy_cover.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/tree/main/data_cleaning/canopy_cover)

**Units:** Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:** California Forest Observatory. (2020). A Statewide Tree-Level Forest Monitoring System. Salo Sciences, Inc. San Francisco, CA. <https://forestobservatory.com>

**Licenses:** For more information regarding licensing please visit: <https://forestobservatory.com/legal.html>

---------------------------------------------------------------------------------------------------------------

**Digital Elevation Model (DEM):**

**Brief description:** Topographic surface of the earth and flattened water surfaces (.tif). Seven tiles were downloaded to cover the extent of the Los Padres National Forest (LPNF). 

Tiles: 

n35w119_20190919

n35w120_20190924

n35w121_20190924

n36w120_20190919

n36w121_20190919

n36w122_20210301

n37w122_20201207 

**How it was accessed:** [USGS\'s The National Map (TNM) download interface;](https://apps.nationalmap.gov/downloader/) searched for California, USA; selected Elevation Products (3DEP) 1 arc-second DEM; downloaded as GeoTIFF.

**Use:** This data was used in the development of the milkweed habitat suitability maps and survey site accessibility index, which were used to create the survey site priority index. This data was initially read in and processed in the following notebook:

[data_cleaning/dem/dem_cleaning.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/tree/main/data_cleaning/dem)

**Units:** Spatial Reference: NAD 1983 (EPSG 4269)

**Citation:** U.S. Geological Survey, 2019, 2020, 2021, USGS 3D Elevation Program Digital Elevation Model <https://apps.nationalmap.gov/downloader/> , courtesy of the U.S. Geological Survey.

**Licenses:** Data from The National Map is free and in the public domain. There are no restrictions on downloaded data; however, we request that the following statement be used when citing, copying, or reprinting data: "Data available from U.S. Geological Survey, National Geospatial Program."

---------------------------------------------------------------------------------------------------------------

**Los Padres National Forest (LPNF) Boundary:**

**Brief description:** Boundary of the northern and southern regions of Los Padres National Forest in California filtered from the Forest Service Administrative Boundaries (.shp)

**How it was accessed:** [USDA Download National Datasets interface](https://data.fs.usda.gov/geodata/edw/datasets.php?dsetCategory=boundaries); Scroll to Administrative Forest Boundaries and Select ESRI Geodatabase; downloaded as GeoDatabase

**Use:** This data was used in the development of the milkweed habitat suitability maps and survey site accessibility index, which were used to create the survey site priority index. This data was initially read in and processed in the following notebook:

[data_cleaning/boundary/lpnf_boundary.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/tree/main/data_cleaning/boundary)

**Units:** esriMeters, Spatial Reference: WGS 1984 Web Mercator Auxiliary Sphere (EPSG 3857)

**Citation:** United States Department of Agriculture Forest Service,Administrative Forest Boundaries. (2024); <https://data.fs.usda.gov/geodata/edw/datasets.php> 

**Licenses:** The USDA Forest Service makes no warranty, expressed or implied, including the warranties of merchantability and fitness for a particular purpose, nor assumes any legal liability or responsibility for the accuracy, reliability, completeness or utility of these geospatial data, or for the improper or incorrect use of these geospatial data. These geospatial data and related maps or graphics are not legal documents and are not intended to be used as such. The data and maps may not be used to determine title, ownership, legal descriptions or boundaries, legal jurisdiction, or restrictions that may be in place on either public or private land. Natural hazards may or may not be depicted on the data and maps, and land users should exercise due caution. The data are dynamic and may change over time. The user is responsible to verify the limitations of the geospatial data and to use the data accordingly.

---------------------------------------------------------------------------------------------------------------

**Santa Barbara Botanic Garden Polygon Data:**

**Brief description:** Polygons indicating the shape of the outer border of observed milkweed plots in the Los Padres National Forest during field surveys in the summer of 2023. Includes information on milkweed species, presence/absence, location and number of plants

**How it was accessed:** Shared directly by the Santa Barbara Botanic Garden as a shapefile.

**Use:** This data was used in the development of the milkweed habitat suitability maps, which were used to create the survey site priority index. The centroids pulled from the polygons in this data were used in the interactive web dashboard created for this project: [milkweed-site-finder](https://github.com/MEDS-SBBG-milkweed/milkweed-site-finder). This data was processed for habitat suitability map development applications in the following script:

[data_cleaning/milkweed_polygon/points_clean_export.R](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/blob/main/data_cleaning/milkweed_polygon/points_clean_export.R)

Data was processed for interactive web dashboard applications in the following notebook:

[data_cleaning/milkweed_polygon/milkweed_subsets_points.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/blob/main/data_cleaning/milkweed_polygon/milkweed_subsets_points.qmd)

**Units:** Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:** Santa Barbara Botanic Garden, shared January 2024

**Licenses:** This data was privately shared with the MilkweedMod capstone team and is part of the Santa Barbara Botanic Garden\'s long-term milkweed restoration project. The capstone team was given permission to share this data by the U.S. Forest Service under the condition that the following disclaimer is included: "Plant and seed collection on Forest Service land is not permissible without a plant collection permit from the Los Padres National Forest".

---------------------------------------------------------------------------------------------------------------

**Trails & Roads Data --- Los Padres Forest Watch:**

**Brief description:** Trails and road geometries, along with names and open/closed status, within the southern section of the Los Padres National Forest as of June 2023

**How it was accessed:** Downloaded from ArcGIS online with an ArcGIS Pro account as a shapefile

**Use:** This data was used in the development of the survey site accessibility index, which was used to create the survey site priority index. More specifically, this data was used to calculate the distance from trails and roads in the southern region of the LPNF. This data was initially read in and processed in the following notebook:

[data_cleaning/trails_and_roads/trails_and_roads.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/tree/main/data_cleaning/trails_and_roads)

**Units:** esriMeters, Spatial Reference: WGS 1984 Pseudo-Mercator (EPSG 3857)

**Citation:** ForestWatchGIS, 2023 Regional Trails and Roads, [Los Padres Forest Watch via ArcGIS](https://services9.arcgis.com/olCAyDMW794Lg7Au/arcgis/rest/services/2023_Regional_Trails_and_Roads/FeatureServer) 

**Licenses:** No license information was provided. For more information regarding licensing, please visit [this](https://services9.arcgis.com/olCAyDMW794Lg7Au/arcgis/rest/services/2023_Regional_Trails_and_Roads/FeatureServer/info/itemInfo?f=pjson) page. 

---------------------------------------------------------------------------------------------------------------

**Trails & Roads Data --- USGS:**

**Brief description:** National Transportation Data (NTD) [California Shapefile](https://www.sciencebase.gov/catalog/item/5f6345ee82ce38aaa238c9df), courtesy of the U.S. Geological Survey -- trails and different types of roads in California (.shp), used data from within the northern region of the LPNF 

**How it was accessed:** Downloaded from the National Transportation Dataset via the USGS ScienceBase Catalog.  

**Use:** This data was used in the development of the survey site accessibility index, which was used to create the survey site priority index. More specifically, this data was used to calculate the distance from trails and roads in the northern region of the LPNF. This data was initially read in and processed in the following notebook:

[data_cleaning/trails_and_roads/trails_and_roads.qmd](https://github.com/MEDS-SBBG-milkweed/milkweed-mod/tree/main/data_cleaning/trails_and_roads)

**Units:** esriMeters, Spatial Reference: NAD 1983 (EPSG 4269)

**Citation:** Courtesy of the U.S. Geological Survey, 2024, USGS National Transportation Dataset (NTD) for California

<https://www.sciencebase.gov/catalog/item/5f6345ee82ce38aaa238c9df> 

**Licenses:** Data from The National Map is free and in the public domain. There are no restrictions on downloaded data; however, we request that the following statement be used when citing, copying, or reprinting data: "Data available from U.S. Geological Survey, National Geospatial Program."

---------------------------------------------------------------------------------------------------------------

## Repository Structure


```
├── data_cleaning                 # data cleaning and preparation
│   ├── accessibility_template
│   │   └── template_raster.qmd
│   ├── bioclim
│   │   └── bioclim.R
│   ├── boundary
│   │   └── lpnf_boundary.qmd
│   ├── canopy_cover
│   │   └── canopy_cover.qmd
│   ├── combine_layers
│   │   └── crop_stack.R
│   ├── dem
│   │   └── dem_cleaning.qmd
│   ├── land_ownership
│   │   └── land_ownership.qmd
│   ├── milkweed_polygon             # milkweed data cleaning & processing
│   │   ├── milkweed_subsets_points.qmd
│   │   ├── points_clean_export.R
│   │   └── survey_points_map.R
│   ├── solar_rad
│   │   └── solar_radiation.qmd
│   └── trails_and_roads
│       └── trails_and_roads.qmd
├── legends                       # legend development for maps
│   └── legend_infographic.qmd
├── LICENSE
├── maxent                        # species distribution modeling/habitat suitability map development
│   ├── A_californica_sdm.qmd
│   ├── A_eriocarpa_sdm.qmd
│   ├── A_erosa_sdm.qmd
│   ├── A_vestita_sdm.qmd
│   └── max_suitability_sdm.qmd
├── milkweed-mod.Rproj
├── outputs
│   ├── dashboard                     # outputs used in milkweed-site-finder dashboard
│   │   ├── accessibility_legend.png
│   │   ├── all_species_points.rda
│   │   ├── californica_sdm.tif
│   │   ├── eriocarpa_sdm.tif
│   │   ├── erosa_sdm.tif
│   │   ├── max_suitable_sdm.tif
│   │   ├── priority_legend.png
│   │   ├── suitability_legend.png
│   │   └── vestita_sdm.tif
│   └── figs
│       └── MilkweedMod-transparent.png   # hex sticker
├── priority_sites                        # survey site priority index development
│   ├── priority_sites.qmd
│   └── priority_sites_table.qmd
├── R                               # scripts
│   ├── accessibility_setup.R
│   ├── addLegend_decreasing.R
│   ├── milkweed_maxent.R
│   ├── rescale_raster.R
│   └── setup.R
├── README.md                    # you are here!
├── session_info.txt             # computing environment specs
├── site_accessibility           # survey site accessibility index development
│   ├── create_accessibility_index.qmd
│   ├── distance_calculations.qmd
│   └── rescale_all_layers.qmd
└── walkthroughs                  # walkthroughs for updating this repo
    └── updating_milkweed-mod.qmd
```



## Technical Documentation


To read more about the project and modeling processes, please refer to our [Bren project page and technical documentation]([https://bren.ucsb.edu/projects/identifying-priority-survey-sites-early-season-milkweed-conservation).



## Disclaimers

Plant and seed collection on Forest Service land is not permissible without a plant collection permit from the Los Padres National Forest.



This project was completed as a part of the [Master of Environmental Data Science]([https://bren.ucsb.edu/masters-programs/master-environmental-data-science) program at the Bren School of Environmental Science & Management at the University of California, Santa Barbara. 



## Authors
 Amanda Herbst { [GitHub](https://github.com/amandaherbst) | [Website](amandaherbst.github.io) | [LinkedIn](https://www.linkedin.com/in/amanda-herbst/) }

 Anna Ramji { [GitHub](https://github.com/annaramji) | [Website](https://annaramji.github.io/) | [LinkedIn](https://www.linkedin.com/in/annaramji/) }

 Melissa Widas { [GitHub](https://github.com/mwidas) | [Website](https://mwidas.github.io/) | [LinkedIn](https://www.linkedin.com/in/mwidas/) }

 Sam Muir { [GitHub](https://github.com/shmuir) | [Website](https://shmuir.github.io/) | [LinkedIn](https://www.linkedin.com/in/shmuir/) }



## Client 



Dr. Sarah Cusser, Terrestrial Invertebrate Conservation Ecologist

Santa Barbara Botanic Garden 

1212 Mission Canyon Rd.

Santa Barbara, CA 93105


