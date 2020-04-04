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
#' @importFrom methods is
#' @export
brMinisterioSaude <- function(silent = !interactive()){
  shift <- 0
  df <- "not_found"
  while(shift < 3 & !is(df, "data.frame")){
    tm <- lubridate::now(tzone = "Brazil/East") - lubridate::days(shift)
    dt <- format.Date(tm, format = "%Y%m%d")
    df <- tryCatch({
      suppressWarnings(
        read.csv(glue("https://covid.saude.gov.br/assets/files/COVID19_{dt}.csv"), 
                 sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8"))
    }, error = function(er) "not_found")
    shift <- shift + 1
  }
  if(!is(df, "data.frame")) stop("Unable to download file.")
  df$data <- lubridate::as_date(as.character(df$data), format = "%d/%m/%y", tz = "Brazil/East")
  if(!silent) cat("Latest Update: ", as.character(max(df$data)), "\n")
  return(tibble::as_tibble(df))
}
