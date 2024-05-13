
#' Rescale Raster Function
#' from a scale of 0-1
#' @author Anna Ramji and Amanda Herbst
#' @param raster a SpatRaster
#'
#' @return rescaled SpatRaster
#'
#' @examples rescale_raster(access_index)

rescale_raster <- function(raster) {
  
  # get minimum and maximum values from raster
  min_max_raster <- terra::minmax(raster)
  
  # rescale raster
  raster_rescaled <- (raster - min_max_raster[1,]) / (min_max_raster[2,] - min_max_raster[1,]) 
  
  # return rescaled raster
  return(raster_rescaled)
  
}