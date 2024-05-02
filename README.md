# milkweed-mod
## Project Description
The milkweed-mod repository houses the R code to process and execute code used to create products to aid the Santa Barbara Botanic Garden's milkweed survey project. The main objectives of this project are to identify high-priority milkweed survey sites, based on habitat suitability and physical accessibility, throughout the Los Padres National Forest (LPNF) to direct Santa Barbara Botanic Garden (SBBG) summer 2024 field surveys. 

## Data
In order to accomplish this objective a multitude of data sources were used. In order to learn more about the data used in this project please visit this projects Technical Documentation.

## Repository Table of Contents
```
├── data_cleaning
│   ├── accessibility_template
│   │   └── template_raster.qmd
│   ├── bioclim
│   │   └── bioclim.R
│   ├── boundary
│   │   └── lpnf_boundary.qmd
│   ├── canopy_cover
│   │   └── canopy_cover.qmd
│   ├── dem
│   │   ├── dem_cleaning.qmd
│   │   └── 
│   ├── land_ownership
│       └── land_ownership.qmd
│   ├── milkweed_polygon
│   │   ├── milkweed_subsets_centroids.qmd
│   │   └── points_clean_export.R
│   └── trails_and_roads
│       └── trails_and_roads.qmd   
├── LICENSE
├── maxent
│   ├── californica_bioclim_canopy_solar.qmd
│   ├── eriocarpa_bioclim_canopy_solar.qmd
│   ├── erosa_bioclim_canopy_solar.qmd
│   └── vestita_bioclim_canopy_solar.qmd
├── milkweed-mod.Rproj
├── priority_sites
│   └── priority_sites.qmd
├── README.md
├── scripts
│   ├── accessibility_setup.R
│   ├── addLegend_decreasing.R
│   ├── crop_stack.R 
│   └── sdm_setup.R
└── site_accessibility
    ├── distance_calculations.qmd
    └── rescale_all_layers.qmd
```
