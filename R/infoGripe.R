#' @name infoGripe
#' @title Data from http://info.gripe.fiocruz.br/
#' 
#' @description Extracts the data from http://info.gripe.fiocruz.br/ displayed
#' when the databases `SRAGCOVID` and `OBITOCOVID` are selected.
#' 
#' @return A `list` with elements `casos` e `obitos`, containing `tibbles`
#' with the distribution of cases and deaths, respectively, by week and
#' age.
#' 
#' @importFrom utils URLencode
#' @export
infoGripe <- function(){
  df <- read.csv("https://gitlab.procc.fiocruz.br/mave/repo/-/raw/master/Dados/InfoGripe/serie_temporal_com_estimativas_recentes.csv",
                 sep = ";")
  df[,"data.de.publicação"] <- as.Date(df[,"data.de.publicação"])
  return(tibble::as_tibble(df))
}
