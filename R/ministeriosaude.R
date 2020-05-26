file_ext <- function(file){ 
    ext <- strsplit(basename(file), split="\\.")[[1]]
    return(ext[-1])
} 

#' @name brMinisterioSaude
#' @title Brazilian Health Ministry COVID data
#' 
#' @description Extracts updated data from Brazilian Health Ministry website 
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
#' @importFrom httr GET add_headers content write_disk
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

  if(file_ext(link) == "csv"){
    df <- tryCatch({
      suppressWarnings(
        read.csv(link, sep = ",", stringsAsFactors = FALSE, encoding = "UTF-8", check.names = FALSE))
          }, error = function(er) "not_found")
  } else if(file_ext(link) == "xlsx"){
      httr::GET(link, write_disk(tf <- tempfile(fileext = ".xlsx")))
      df <- suppressWarnings(
        readxl::read_xlsx(tf, sheet = 1, progress = !silent, col_types = "text"))
  }


  if(!is(df, "data.frame")) stop("The file is not available at the previous address.
                                 Consider updating datacovidbr.")
  dfvars <- colnames(df) 
  if("data" %in% dfvars){
    colnames(df)[colnames(df) == "data"] <- "date"
    df$date <- as.Date(df$date)
  }
  if("casosAcumulado" %in% dfvars) df$casosAcumulado <- as.integer(df$casosAcumulado)
  if("casosNovos" %in% dfvars) df$casosNovos <- as.integer(df$casosNovos)
  if("obitosAcumulado" %in% dfvars) df$obitosAcumulado <- as.integer(df$obitosAcumulado)
  if("obitosNovos" %in% dfvars) df$obitosNovos <- as.integer(df$obitosNovos)
  if("populacaoTCU2019" %in% dfvars) df$populacaoTCU2019 <- as.integer(df$populacaoTCU2019)
  if("Recuperadosnovos" %in% dfvars) df$Recuperadosnovos <- as.integer(df$Recuperadosnovos)
  if("emAcompanhamentoNovos" %in% dfvars) df$emAcompanhamentoNovos <- as.integer(df$emAcompanhamentoNovos)
  if("CodRegiaoSaude" %in% dfvars) df$CodRegiaoSaude <- as.integer(df$CodRegiaoSaude)
  if("coduf" %in% dfvars)  df$coduf <- as.integer(df$coduf)
  if("codmun" %in% dfvars) df$codmun <- as.integer(df$codmun)
  if("semanaEpi" %in% dfvars) df$semanaEpi <- as.integer(df$semanaEpi)
  
  if(!silent) cat("Latest Update: ", as.character(max(df$date)), "\n")
  return(tibble::as_tibble(df))
}
