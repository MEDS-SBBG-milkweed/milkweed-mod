library(wallace)

# Define base directory file path
base_dir <- here::here("~/Library/CloudStorage/Box-Box/MEDS-SBBG-milkweed")

# Download environmental data
envs_Ac_E <- envs_worldclim(
  bcRes = 0.5, # resolution 30arc seconds
  bcSel = c('bio01', 'bio02', 'bio03', 'bio04', 'bio05', 'bio06', 'bio07', 'bio08', 'bio09', 'bio10', 'bio11', 'bio12', 'bio13', 'bio14', 'bio15', 'bio16', 'bio17', 'bio18', 'bio19'), # select all bioclim vars
   mapCntr = c(-119.658, 34.909), # Mandatory for 30 arcsec resolution - might need to adjust
  doBrick = FALSE)

envs_Ac_W <- envs_worldclim(
  bcRes = 0.5, # resolution 30arc seconds
  bcSel = c('bio01', 'bio02', 'bio03', 'bio04', 'bio05', 'bio06', 'bio07', 'bio08', 'bio09', 'bio10', 'bio11', 'bio12', 'bio13', 'bio14', 'bio15', 'bio16', 'bio17', 'bio18', 'bio19'), # select all bioclim vars
   mapCntr = c(-120.478, 38.271), # Mandatory for 30 arcsec resolution - might need to adjust
  doBrick = FALSE)

#Mosaic the two tiles together to get whole study region
envs_Ac <- terra::mosaic(envs_Ac_W, envs_Ac_E, fun = "mean")

writeRaster(envs_Ac, here::here(base_dir, "clean_data", "bioclim", "wallace_bioclim.tif"))

biclim <- brick(here::here(base_dir, "clean_data", "bioclim", "wallace_bioclim.tif"))