#' @name brasilio
#' @title brasil.io covid data
#' 
#' @description Extracts updated data from the brasil.io page
#' by download the file in `.csv` format available and loading it into a comprehensive
#' `tibble` object.
#' 
#' @param silent `logical` indicating if messages should be hidden.
#' 
#' @return A `tibble` object.
#' @export
brasilio <- function(silent = !interactive()){
  mun <- read.csv("https://brasil.io/dataset/covid19/caso?format=csv", 
                  stringsAsFactors = FALSE)
  mun$date <- as.Date(mun$date)
  mun$is_last <- ifelse(mun$is_last == "True", TRUE, FALSE)
  if(!silent) cat("Latest Update: ", as.character(max(mun$date)), "\n")
  return(as_tibble(mun))
}
