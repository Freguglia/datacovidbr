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
  df <- "not_found"
  link <- readChar("https://www.ime.unicamp.br/~ra137784/brMinisterioSaude", nchars = 500) %>% 
    strsplit("\n") %>% unlist()
  df <- tryCatch({
    suppressWarnings(
      read.csv(link, sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8"))
  }, error = function(er) "not_found")

  if(!is(df, "data.frame")) stop("The file is not available at the previous address.
                                 Consider updating the package.")
  df$data <- lubridate::as_date(as.character(df$data), format = "%d/%m/%y", tz = "Brazil/East")
  if(!silent) cat("Latest Update: ", as.character(max(df$data)), "\n")
  return(tibble::as_tibble(df))
}
