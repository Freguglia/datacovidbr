#' @name registro_civil
#' @title Dados de https://transparencia.registrocivil.org.br/
#' 
#' @param state Estado no padrão `"SP"` ou `"all"` para o Brasil inteiro.
#' @param city_id ID de cidade. Uma tabela do ID por cidade pode ser encontrada
#' no objeto `registro_civil_cidades`.
#' 
#' @return Um `tibble` com as mortes por gênero, faixa etária e causa nos anos de 
#' 2019 e 2020, do dia 16 de março até a data atual.
#' 
#' @importFrom dplyr bind_rows select
#' @importFrom tidyr pivot_longer
#' @importFrom httr GET content add_headers
#' @importFrom glue glue
#' @importFrom lubridate today
#' @importFrom tibble as_tibble
#' 
#' @export
registro_civil <- function(state = "all", city_id = "all"){
  if(length(city_id) > 1){stop("Um 'city_id' por vez, ou 'all' para todas as cidades to estado.")}
  if(length(state) > 1){stop("Um 'state' por vez, ou 'all' para o brasil inteiro.")}
  out <- data.frame()
  for(gender in c("M", "F")){
  api_url <- glue::glue("https://transparencia.registrocivil.org.br/api/covid-covid-registral?start_date=2020-03-16&end_date={lubridate::today()-1}&state={state}&city_id={city_id}&chart=chart2&gender={gender}")
  a <- GET(api_url, add_headers("user-agent" = "Mozilla/5.0")) %>% content() %>% "[["("chart")
  df <- lapply(a, function(age){
    lapply(age, as.data.frame) %>%
      bind_rows(.id = "ano")
  }) %>% bind_rows(.id = "idade") %>%
    pivot_longer(cols = -c(ano, idade), names_to = "causa", values_to = "mortes")
  df$gender <- gender
  out <- rbind(out, df)
  }
  return(as_tibble(out))
}

#' @rdname registro_civil
#' 
#' @export
registro_civil_diario <- function(state = "all", city_id = "all"){
  if(length(city_id) > 1){stop("Um 'city_id' por vez, ou 'all' para todas as cidades to estado.")}
  if(length(state) > 1){stop("Um 'state' por vez, ou 'all' para o brasil inteiro.")}
  api_url <- glue::glue("https://transparencia.registrocivil.org.br/api/covid-covid-registral?start_date=2020-03-16&end_date={today()}&state={state}&city_id={city_id}&places[]=HOSPITAL&places[]=DOMICILIO&places[]=VIA_PUBLICA&places[]=AMBULANCIA&places[]=OUTROS&chart=chart5")
  a <- GET(api_url, add_headers("user-agent" = "Mozilla/5.0")) %>% content() %>% "[["("chart")
  df <- lapply(a, function(date){
    lapply(date, as.data.frame) %>%
      bind_rows(.id = "causa")
  }) %>% 
    bind_rows(.id = "dia") %>%
    select(-data_obito, -tipo_doenca, -dia_obito)
  df$dia <- as.Date(strftime(df$dia, format = "%d-%m-%y"))
  df$total <- as.numeric(df$total)
  return(as_tibble(df))
}
