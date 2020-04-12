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
#' @importFrom httr GET add_headers content
#' @export
brMinisterioSaude <- function(silent = !interactive()){
  df <- "not_found"
  link <- GET("https://xx9p7hp1p7.execute-api.us-east-1.amazonaws.com/prod/PortalGeral",
              add_headers("X-Parse-Application-Id" = 
                            "unAFkcaNDeXajurGB7LChj8SgQYS2ptm")) %>%
    content() %>%
    '[['("results") %>%
    '[['(1) %>%
    '[['("arquivo") %>%
    '[['("url")
  df <- tryCatch({
    suppressWarnings(
      read.csv(link, sep = ";", stringsAsFactors = FALSE, encoding = "UTF-8", check.names = FALSE))
  }, error = function(er) "not_found")

  if(!is(df, "data.frame")) stop("The file is not available at the previous address.
                                 Consider updating the datacovidbr")
  colnames(df)[1] <- "regiao"
  colnames(df)[3] <- "date"
  df$date <- as.Date(df$date)
  if(!silent) cat("Latest Update: ", as.character(max(df$date)), "\n")
  return(tibble::as_tibble(df))
}
