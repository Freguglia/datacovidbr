# @name infoGripe
# @title Data from http://info.gripe.fiocruz.br/
# 
# @description Extracts the data used in http://info.gripe.fiocruz.br/.
# A description of the dataset is available at the link in the references.
# 
# @return A `list` with elements `casos` e `obitos`, containing `tibbles`
# with the distribution of cases and deaths, respectively, by week and
# age.
#
# @references https://gitlab.procc.fiocruz.br/mave/repo/-/tree/master/Dados/InfoGripe
# 
# @importFrom utils URLencode
# @export
infoGripe <- function(){
  df <- read.csv("https://gitlab.procc.fiocruz.br/mave/repo/-/raw/master/Dados/InfoGripe/serie_temporal_com_estimativas_recentes.csv",
                 sep = ";")
  colnames(df) <- c("data", "UF", "unidade_da_federacao", "tipo", 
                    "dado", "escala", "ano_epidemiologico","semana_epidemiologica",
                    "situacao_do_dado", "total_reportado", 
                    "limite_inferior_estimativa", "casos_estimados",
                    "limite_superior_estimativa", "percentual", "populacao")
  df$data <- as.Date(df$data)
  df$total_reportado <- as.numeric(gsub(",", ".", df$total_reportado))
  df$limite_inferior_estimativa <- as.numeric(gsub(",", ".", df$limite_inferior_estimativa))
  df$casos_estimados <- as.numeric(gsub(",", ".", df$casos_estimados))
  df$limite_superior_estimativa <- as.numeric(gsub(",", ".", df$limite_superior_estimativa))
  df$percentual <- as.numeric(gsub(",", ".", df$percentual))/100
  
  return(tibble::as_tibble(df))
}
