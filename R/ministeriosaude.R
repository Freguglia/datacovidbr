#' @name brMinisterioSaude
#' @title Brazilian Health Ministry COVID data
#' 
#' @description Extracts updated data from the page of Brazilian Health Ministry 
#' (https://covid.saude.gov.br/)
#' by download the file in `.csv` format available and loading it into a comprehensive
#' `tibble` object.
#' 
#' @param silent `logical` indicating if messages should be hidden.
#' 
#' @return A `tibble` object.
#' 
#' @importFrom glue glue
#' @export
brMinisterioSaude <- function(silent = !interactive()){
  tm <- lubridate::now(tzone = "Brazil/East") - lubridate::days(1)
  dt <- format.Date(tm, format = "%Y%m%d")
  df <- read.csv(glue("https://covid.saude.gov.br/assets/files/COVID19_{dt}.csv"), sep = ";")
  df$data <- lubridate::as_date(as.character(df$data), format = "%d/%m/%y", tz = "Brazil/East")
  if(!silent) cat("Latest Update: ", as.character(max(df$data)), "\n")
  return(tibble::as_tibble(df))
}
