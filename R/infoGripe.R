#' @param state `character` vector com UFs inclusos.
#' @export
infoGripe <- function(state = NULL){
  casos <- data.frame()
  if(is.null(state)) {
    state <- c("Alagoas", "Amapá", "Bahia", "Ceará", "Distrito Federal", 
               "Espírito Santo", "Goiás", "Maranhão", "Minas Gerais", "Mato Grosso do Sul",
               "Mato Grosso", "Pará", "Paraíba", "Pernambuco", "Piauí", "Paraná", "Rio de Janeiro",
               "Rio Grande do Norte", "Rondônia", "Roraima", "Rio Grande do Sul", "Santa Catarina",
               "Sergipe", "São Paulo", "Tocantins")
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