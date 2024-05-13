
milkweed_maxent <- function(df, species, env_stack, pred_area) {
  
  # rename milkweed occurrence data
  occs_Ac <- df %>%
    filter(milkweed_sp == species)
  
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
  bgEnvsVals_Ac <- cbind(scientific_name = paste0("bg_", species), bgSample_Ac,
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
    rms = c(1, 3), # change 
    rmsStep =  1,
    fcs = c('L', 'LQ'),
    clampSel = FALSE,
    algMaxent = "maxnet",
    parallel = FALSE,
    numCores = 7)
  
 return(model_Ac)
 
}


