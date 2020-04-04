#' @name CSSEGISandData
#' @title Data from the `CSSEGISandData/COVID-19` repository
#' 
#' @description Extracts updated data from the repository by Johns Hopkins CSSE
#' (https://github.com/CSSEGISandData/COVID-19)
#' by download the file in `.csv` format available and loading it into a comprehensive
#' `tibble` object.
#' 
#' @inheritParams brMinisterioSaude
#' 
#' @return A `tibble` object.
#' 
#' @importFrom dplyr summarise group_by left_join
#' @importFrom magrittr %>%
#' @importFrom tidyselect starts_with
#' @export
CSSEGISandData <- function(silent = !interactive()){
  df_cases <- read.csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv",
                       stringsAsFactors = FALSE, encoding = "utf-8")
  df_cases <- tidyr::pivot_longer(df_cases, cols = starts_with("X"),
                                  names_to = "data", values_to = "casosAcumulados")
  df_cases$data <- gsub("X", df_cases$data, replacement = "")
  df_cases$data <- lubridate::as_date(as.character(df_cases$data),
                                      format = "%m.%d.%y", tz = "UTC")
  df_cases <- df_cases %>% group_by(Country.Region, data) %>%
    summarise(casosAcumulados = sum(casosAcumulados, na.rm = TRUE))
  
  df_deaths <- read.csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv",
                        stringsAsFactors = FALSE, encoding = "utf-8")
  df_deaths <- tidyr::pivot_longer(df_deaths, cols = starts_with("X"),
                                   names_to = "data", values_to = "obitosAcumulado")
  df_deaths$data <- gsub("X", df_deaths$data, replacement = "")
  df_deaths$data <- lubridate::as_date(as.character(df_deaths$data),
                                       format = "%m.%d.%y", tz = "UTC")
  df_deaths <- df_deaths %>% group_by(Country.Region, data) %>%
    summarise(obitosAcumulado = sum(obitosAcumulado, na.rm = TRUE))
  
  df_recovered <- read.csv("https://github.com/CSSEGISandData/COVID-19/raw/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv",
                           stringsAsFactors = FALSE, encoding = "utf-8")
  df_recovered <- tidyr::pivot_longer(df_recovered, cols = starts_with("X"),
                                      names_to = "data", values_to = "recuperadosAcumulado")
  df_recovered$data <- gsub("X", df_recovered$data, replacement = "")
  df_recovered$data <- lubridate::as_date(as.character(df_recovered$data),
                                          format = "%m.%d.%y", tz = "UTC")
  df_recovered <- df_recovered %>% group_by(Country.Region, data) %>%
    summarise(recuperadosAcumulado = sum(recuperadosAcumulado, na.rm = TRUE))
  
  if(!silent) cat("Latest Update: ", as.character(max(df_recovered$data)), "\n")
  
  return(df_cases %>%
           left_join(df_deaths, by = c("Country.Region", "data")) %>%
           left_join(df_recovered, by = c("Country.Region", "data")))
}