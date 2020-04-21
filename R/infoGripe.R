#' @name infoGripe
#' @title Data from http://info.gripe.fiocruz.br/
#' 
#' @description Extracts the data from http://info.gripe.fiocruz.br/ displayed
#' when the databases `SRAGCOVID` and `OBITOCOVID` are selected.
#' 
#' @param state `character` vector with UFs to include.
#' 
#' @return A `list` with elements `casos` e `obitos`, containing `tibbles`
#' with the distribution of cases and deaths, respectively, by week and
#' age.
#' 
#' @importFrom utils URLencode
#' @export
infoGripe <- function(state = NULL){
  casos <- data.frame()
  if(is.null(state)) {
    state <- c("Alagoas", "Amap\u00e1", "Bahia", "Cear\u00e1", "Distrito Federal", 
               "Esp\u003drito Santo", "Goiu00e1s", "Maranh\u00e3o", "Minas Gerais", "Mato Grosso do Sul",
               "Mato Grosso", "Par\u00e1", "Para\u003dba", "Pernambuco", "Piau\u003d", "Paran\u00e1", "Rio de Janeiro",
               "Rio Grande do Norte", "Rond\u00f4nia", "Roraima", "Rio Grande do Sul", "Santa Catarina",
               "Sergipe", "S\u00e3o Paulo", "Tocantins")
  }
  for(i in state){
    if(interactive()) { cat("\r Loading", i, "                    ") }
    urls <- paste0('http://info.gripe.fiocruz.br/data/detailed/4/2/2020/', 1:15, "/", URLencode(i), "/age-distribution")
    reqs <- lapply(urls, read.csv) %>% dplyr::bind_rows(.id = "Semana") %>% cbind(UF = i)
    casos <- rbind(casos, reqs)
  }
  
  obitos <- data.frame()
  for(i in state){
    if(interactive()) { cat("\r Loading", i, "                    ") }
    urls <- paste0('http://info.gripe.fiocruz.br/data/detailed/5/2/2020/', 1:15, "/", URLencode(i), "/age-distribution")
    reqs <- lapply(urls, read.csv) %>% dplyr::bind_rows(.id = "Semana") %>% cbind(UF = i)
    if(ncol(reqs) > 3)
    obitos <- rbind(obitos, reqs)
  }
  return(list(casos = tibble::as_tibble(casos), obitos = tibble::as_tibble(obitos)))
}