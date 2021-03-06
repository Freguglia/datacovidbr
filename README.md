
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datacovidbr

<!-- badges: start -->

[![build
status](https://travis-ci.org/Freguglia/datacovidbr.svg?branch=master)](https://travis-ci.org/Freguglia/datacovidbr)
<!-- badges: end -->

O `datacovidbr` é um pacote em R com o objetivo de facilitar a
importação e leitura dos dados da COVID-19 de fontes brasileiras e
mundiais, automatizando os mecanismos de análise desses dados em R. No
momento as fontes de dados disponíveis são:

  - Dados do [Ministério da Saúde](https://covid.saude.gov.br/) para
    dados brasileiros por estados e regiões.
  - Repositório [Brasil.io](https://brasil.io/home) para dados
    brasileiros por município.
  - Repositório
    [CSSEGISandData/COVID-19](https://github.com/CSSEGISandData/COVID-19)
    mantido pela Johns Hopkins University Center for Systems Science and
    Engineering (JHU CSSE).
  - Dados do [infoGripe](http://info.gripe.fiocruz.br/).

<!-- * Dados do Painel COVID Registral do [Registro Civil](https://transparencia.registrocivil.org.br/registral-covid). -->

Algumas funções fazem download de fontes de dados quando estão
disponíveis e fazem um mínimo de pré-processamento, outras obtém os
dados das fontes por web-scraping.

## Instalação

Pela alta demanda no momento no CRAN, que gera muita demora no processo
de aceitação de novos pacotes e atualizações, o `datacovidbr` será
mantido apenas no Github. Para instalação de pacotes disponíveis no
Github, basta utilizar a função abaixo:

``` r
# install.packages("devtools")
devtools::install_github("Freguglia/datacovidbr")
```

## Exemplo

Os dados podem ser carregados com as funções `brMinisterioSaude()`,
`brasilio()`, `CSSEGISandData()`, `infoGripe()`:

``` r
library(datacovidbr)
# Dados do Ministério da Saúde
est <- brMinisterioSaude()
est
#> # A tibble: 82,282 x 14
#>    regiao estado municipio coduf codmun codRegiaoSaude nomeRegiaoSaude
#>    <chr>  <chr>  <chr>     <chr> <chr>  <chr>          <chr>          
#>  1 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  2 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  3 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  4 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  5 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  6 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  7 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  8 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#>  9 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#> 10 Brasil <NA>   <NA>      76    <NA>   <NA>           <NA>           
#> # … with 82,272 more rows, and 7 more variables: date <date>, semanaEpi <chr>,
#> #   populacaoTCU2019 <dbl>, casosAcumulado <dbl>, obitosAcumulado <dbl>,
#> #   Recuperadosnovos <dbl>, emAcompanhamentoNovos <dbl>

# Dados do Brasil.io
mun <- brasilio()
mun
#> # A tibble: 85,615 x 11
#>    date       state city  place_type confirmed deaths is_last estimated_popul…
#>    <date>     <chr> <chr> <chr>          <int>  <int> <lgl>              <int>
#>  1 2020-05-16 AC    Acre… city              67      1 TRUE               15256
#>  2 2020-05-16 AC    Assi… city               1      0 TRUE                7417
#>  3 2020-05-16 AC    Bras… city               2      0 TRUE               26278
#>  4 2020-05-16 AC    Buja… city              18      0 TRUE               10266
#>  5 2020-05-16 AC    Capi… city               2      0 TRUE               11733
#>  6 2020-05-16 AC    Cruz… city             210      1 TRUE               88376
#>  7 2020-05-16 AC    Epit… city               4      0 TRUE               18411
#>  8 2020-05-16 AC    Feijó city               2      0 TRUE               34780
#>  9 2020-05-16 AC    Impo… city               0      0 TRUE                  NA
#> 10 2020-05-16 AC    Mânc… city               5      0 TRUE               18977
#> # … with 85,605 more rows, and 3 more variables: city_ibge_code <int>,
#> #   confirmed_per_100k_inhabitants <dbl>, death_rate <dbl>

#Dados da CSSEGISandData
wor <- CSSEGISandData()
wor
#> # A tibble: 21,808 x 7
#>    Country.Region data         Lat  Long casosAcumulados obitosAcumulado
#>    <chr>          <date>     <dbl> <dbl>           <int>           <int>
#>  1 Afghanistan    2020-01-22    33    65               0               0
#>  2 Afghanistan    2020-01-23    33    65               0               0
#>  3 Afghanistan    2020-01-24    33    65               0               0
#>  4 Afghanistan    2020-01-25    33    65               0               0
#>  5 Afghanistan    2020-01-26    33    65               0               0
#>  6 Afghanistan    2020-01-27    33    65               0               0
#>  7 Afghanistan    2020-01-28    33    65               0               0
#>  8 Afghanistan    2020-01-29    33    65               0               0
#>  9 Afghanistan    2020-01-30    33    65               0               0
#> 10 Afghanistan    2020-01-31    33    65               0               0
#> # … with 21,798 more rows, and 1 more variable: recuperadosAcumulado <int>
```

Os `data.frames` já vem em um formato que pode ser utilizado com todas
as outras ferramentas disponíveis em R, por exemplo, o `ggplot2`.

``` r
library(ggplot2)
ggplot(est[est$regiao != "Brasil" & is.na(est$municipio) & is.na(est$codmun),],
       aes(x = date, y = casosAcumulado, group = estado, color = regiao)) +
  geom_line() +
  scale_x_date(limits = c(as.Date("2020-03-15"),NA)) 
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="60%" />

## Contribuições e Dúvidas

Caso queira contribuir de alguma forma, pode enviar um Pull Request ou
abrir uma Issue caso tenha dúvidas. Contribuições podem ser em forma de

  - Sugestões em geral
  - Melhorias no pré-processamento
  - Inclusão de novas fontes para importar dados
  - Reportar problemas encontrados
