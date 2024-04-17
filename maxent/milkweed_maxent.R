
milkweed_maxent <- function(df, species, env_stack, pred_area, transfer_area) {
  
  # rename milkweed occurrence data
  occs_Ac <- df
  
  # extract environmental data from the lat and lon
  occs_geom_Ac <- occs_Ac[c("longitude", "latitude")]
  occs_vals_Ac <- as.data.frame(raster::extract(env_stack, occs_geom_Ac, cellnumbers = TRUE))

  # add columns for env variable values for each occurrence record
  occs_Ac <- cbind(occs_Ac, occs_vals_Ac)
  
  # process occurrences
  occs_Ac <- poccs_thinOccs(
    occs = occs_Ac, 
    thinDist = 0.05) # adjust this value if needed
  
  # Generate background extent
  bgExt_Ac <- pred_area
  
  # Mask environmental data to provided extent
  bgMask_Ac <- penvs_bgMask(
    occs = occs_Ac,
    envs = env_stack,
    bgExt = bgExt_Ac)
  # Sample background points from the provided area
  bgSample_Ac <- penvs_bgSample(
    occs = occs_Ac,
    bgMask =  bgMask_Ac,
    bgPtsNum = 7000)
  # Extract values of environmental layers for each background point
  bgEnvsVals_Ac <- as.data.frame(raster::extract(bgMask_Ac,  bgSample_Ac))
  ##Add extracted values to background points table
  bgEnvsVals_Ac <- cbind(scientific_name = paste0("bg_", "Asclepias eriocarpa"), bgSample_Ac,
                         occID = NA, year = NA, institution_code = NA, country = NA,
                         state_province = NA, locality = NA, elevation = NA,
                         record_type = NA, bgEnvsVals_Ac)
  
  # Partition data
  groups_Ac <- part_partitionOccs(
    occs = occs_Ac ,
    bg =  bgSample_Ac, 
    method = "block") 
  
  # Run maxent model for the selected species
  model_Ac <- model_maxent(
    occs = occs_Ac,
    bg = bgEnvsVals_Ac,
    user.grp = groups_Ac, 
    bgMsk = bgMask_Ac,
    rms = c(1, 3), 
    rmsStep =  1,
    fcs = c('L', 'LQ'),
    clampSel = FALSE,
    algMaxent = "maxnet",
    parallel = FALSE,
    numCores = 7)
  
  # select model and predict
  auc_max <- model_Ac@results %>%
    select(tune.args, auc.train) %>%
  arrange(desc(auc.train)) %>%
    head(1) %>%
    mutate(tune.args = as.character(tune.args))
 
   
 
 m_Ac <- model_Ac@models[[auc_max$tune.args]] # change this for different models
 predSel_Ac <- predictMaxnet(m_Ac, bgMask_Ac,
                             type = "cloglog", # change for different types
                             clamp = FALSE)
 #Get values of prediction
 mapPredVals_Ac <- getRasterVals(predSel_Ac, "cloglog") # change for different types
 
 
# Generate a transfer of the model to the desired area
 xfer_area_Ac <- xfer_area(
   evalOut = model_Ac,
   curModel = auc_max$tune.args,
   envs = env_stack, 
   outputType = "cloglog",
   alg = "maxnet",
   clamp = FALSE,
   xfExt = transfer_area) 
 
 
 ## Mapping --
 #Define colors and legend  
 rasCols <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
 
 legendPal <- colorNumeric(rasCols, mapPredVals_Ac, na.color = 'transparent')
 rasPal <- colorNumeric(rasCols, mapPredVals_Ac, na.color = 'transparent')
 
 #map result
 mapXferVals_Ac <- getRasterVals(xfer_area_Ac$xferArea,"cloglog")
 rasCols_Ac <- c("#2c7bb6", "#abd9e9", "#ffffbf", "#fdae61", "#d7191c")
 # if no threshold specified
 legendPal <- colorNumeric(rev(rasCols_Ac), mapXferVals_Ac, na.color = 'transparent')
 rasPal_Ac <- colorNumeric(rasCols_Ac, mapXferVals_Ac, na.color = 'transparent')
 
 # merge rasters
 merge(xfer_area_Ac$xferArea, predSel_Ac)
 
 # plot
mod_plot <- leaflet() %>% addProviderTiles(providers$Esri.WorldTopoMap) %>%
   addLegend_decreasing("bottomleft", pal = legendPal, values = mapXferVals_Ac, layerId = "xfer",
                        labFormat = reverseLabel(), decreasing = FALSE,
                        title = paste(species, "<br>Predicted Suitability<br>")) %>%
   # map model prediction raster and transfer polygon
   clearMarkers() %>% clearShapes() %>% removeImage('xferRas') %>%
   addRasterImage(xfer_area_Ac$xferArea, colors = rasPal_Ac, opacity = 0.7,
                  layerId = 'xferRas', group = 'xfer', method = "ngb") %>%
   ##add transfer polygon (user drawn area)
   addPolygons(data = transfer_area, fill = FALSE,
               weight = 2, color = "black", group = 'xfer')  %>%
   addCircleMarkers(data = occs_Ac, lat = ~latitude, lng = ~longitude,
                    radius = 2, color = 'black', fill = TRUE, fillColor = "black",
                    fillOpacity = 0.2, weight = 2) %>% 
   ##Add model prediction
   addRasterImage(predSel_Ac, colors = rasPal, opacity = 0.7,
                  group = 'vis', layerId = 'mapPred', method = "ngb") %>%
   addPolygons(data = pred_area,
               fill = FALSE,
               color = "black",
               weight = 2)
 
 return(mod_plot)
 
}


