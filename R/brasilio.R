#' @name brasilio
#' @title brasil.io covid data
#' 
#' @description Extracts updated data from the brasil.io page
#' by download the file in `.csv` format available and loading it into a comprehensive
#' `tibble` object.
#' 
#' @param silent `logical` indicating if messages should be hidden.
#' @param cache `logical` indicating if cached results should be used (if they exist).
#' @param invalidate_after The time (in hours) to invalidate the cache.
#' 
#' @return A `tibble` object.
#' 
#' @export
brasilio <- function(silent = !interactive(), cache = FALSE, invalidate_after = 12){
  if(cache){
    # Check if there is cached data
    if(file.exists(file.path(".datacovidbr", "brasilio.RDS")) &&
       file.exists(file.path(".datacovidbr", "brasilio_meta.txt"))){
      # If there is, check time difference
      latest_update_time <- lubridate::as_datetime(
        readLines(file.path(".datacovidbr","brasilio_meta.txt")))
      if(lubridate::now(tz = "UTC") - latest_update_time < lubridate::dhours(invalidate_after)){
        mun <- readRDS(file.path(".datacovidbr", "brasilio.RDS"))
        return(tibble::as_tibble(mun))
      }
    }
  } 
    
  mun <- readr::read_csv("https://data.brasil.io/dataset/covid19/caso.csv.gz")
  mun$date <- as.Date(mun$date)
  mun$is_last <- ifelse(mun$is_last == "True", TRUE, FALSE)
  if(!silent) cat("Latest Update: ", as.character(max(mun$date)), "\n")
  if(cache){
    dir.create(".datacovidbr", showWarnings = FALSE)
    saveRDS(mun, file = file.path(".datacovidbr", "brasilio.RDS"))
    writeLines(as.character(lubridate::now(tz = "UTC")), con = file.path(".datacovidbr", "brasilio_meta.txt"))
  }
  return(tibble::as_tibble(mun))
}
