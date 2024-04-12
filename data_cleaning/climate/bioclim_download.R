
## DO NOT NEED TO RUN THIS SCRIPT AGAIN- BIOCLIM HAS BEEN DOWNLOADED AS bioclim.tif
## use plotting code and bioclim names as references 

library(raster)
#devtools::install_github("kapitzas/WorldClimTiles")
library(WorldClimTiles)

#Download tiles
tilenames <- c("11","12")
tiles <- tile_get(tilenames, "bio")
tiles
#Merge the downloaded tiles layer by layer. The function produces a raster stack that contains the merged layers with the correct variable names.
merged <- tile_merge(tiles)

plot(merged[[1]]) #Plotting bioclim 1 - much better!

#Let's change the names to have a better defined raster
bioclim_names <-c("Annual_Mean_Temp",
                  "Mean_Diurnal_Range",
                  "Isothermality",
                  "Temp_Seasonality",
                  "Max_Temp_Warmest Month",
                  "Min_Temp_Coldest_Month",
                  "Temp_Annual_Range",
                  "Mean_Temp_Wettest_Quarter",
                  "Mean_Temp_Driest_Quarter",
                  "Mean_Temp_Warmest_Quarter",
                  "Mean_Temp_Coldest_Quarter",
                  "Annual_Precip",
                  "Precip_Wettest_Month",
                  "Precip_Driest_Month",
                  "Precip_Seasonality",
                  "Precip_Wettest_Quarter",
                  "Precip_Driest_Quarter",
                  "Precip_Warmest_Quarter",
                  "Precip_Coldest_Quarter"
)

names(merged) <- bioclim_names

#We can look in more detail at the rasters within the stack 
plot(merged[[13]], main = names(merged[[13]]))

#Lets save your environmental data as a GeoTIFF file
outfile <- writeRaster(merged, filename=file.path(milkweed_path, 'bioclim.tif'), format="GTiff", overwrite=TRUE,options=c("INTERLEAVE=BAND","COMPRESS=LZW"))

#if you want to read back your environmental RasterBrick data
milkweed_path <- here("~/../../capstone/milkweedmod/data/bioclim/")
envdata <- brick(here("~/../../capstone/milkweedmod/data/bioclim/bioclim.tif"))

plot(envdata[[1]])

st_crs(merged)
