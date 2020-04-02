
<!-- README.md is generated from README.Rmd. Please edit that file -->

# datacovidbr

<!-- badges: start -->

[![build
status](https://travis-ci.org/Freguglia/datacovidbr.svg?branch=master)](https://travis-ci.org/Freguglia/datacovidbr)
<!-- badges: end -->

O `datacovidbr` é um pacote em R com o objetivo de facilitar a
importação e leitura dos dados da COVID-19 de fontes brasileiras e
mundiais, automatizando os mecanismos de análise desses dados em R. No
momento os dados disponíveis são os do Ministério da Saúde
(<https://covid.saude.gov.br/>) para dados brasileiros e os do
repositório
[CSSEGISandData/COVID-19](https://github.com/CSSEGISandData/COVID-19)
mantido pela Johns Hopkins University Center for Systems Science and
Engineering (JHU CSSE).

As funções importam os dados atualizados diretamente, assim você não
precisa baixar os arquivos todos os dias e ler do seu próprio computador
ou ter o trabalho de automatizar isso :) Também é feito algum
pré-processamento para que a estrutura dos dados da `CSSEGISandData`
fique mais parecida com a do Ministério da Saúde.

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

Os dados podem ser carregados com as funções `brMinisterioSaude()` e
`CSSEGISandData()`:

``` r
library(datacovidbr)
# Dados do Ministério da Saúde
bra <- brMinisterioSaude()
#> Latest Update:  2020-04-01
bra
#> # A tibble: 1,701 x 7
#>    regiao estado data       casosNovos casosAcumulados obitosNovos
#>    <fct>  <fct>  <date>          <int>           <int>       <int>
#>  1 Norte  RO     2020-01-30          0               0           0
#>  2 Norte  RO     2020-01-31          0               0           0
#>  3 Norte  RO     2020-02-01          0               0           0
#>  4 Norte  RO     2020-02-02          0               0           0
#>  5 Norte  RO     2020-02-03          0               0           0
#>  6 Norte  RO     2020-02-04          0               0           0
#>  7 Norte  RO     2020-02-05          0               0           0
#>  8 Norte  RO     2020-02-06          0               0           0
#>  9 Norte  RO     2020-02-07          0               0           0
#> 10 Norte  RO     2020-02-08          0               0           0
#> # … with 1,691 more rows, and 1 more variable: obitosAcumulado <int>

#Dados da CSSEGISandData
wor <- CSSEGISandData()
#> Latest Update:  2020-04-01
wor
#> # A tibble: 12,780 x 5
#> # Groups:   Country.Region [180]
#>    Country.Region data       casosAcumulados obitosAcumulado recuperadosAcumula…
#>    <fct>          <date>               <int>           <int>               <int>
#>  1 Afghanistan    2020-01-22               0               0                   0
#>  2 Afghanistan    2020-01-23               0               0                   0
#>  3 Afghanistan    2020-01-24               0               0                   0
#>  4 Afghanistan    2020-01-25               0               0                   0
#>  5 Afghanistan    2020-01-26               0               0                   0
#>  6 Afghanistan    2020-01-27               0               0                   0
#>  7 Afghanistan    2020-01-28               0               0                   0
#>  8 Afghanistan    2020-01-29               0               0                   0
#>  9 Afghanistan    2020-01-30               0               0                   0
#> 10 Afghanistan    2020-01-31               0               0                   0
#> # … with 12,770 more rows
```

Os `data.frames` já vem em um formato que pode ser utilizado com todas
as outras ferramentas disponíveis em R, por exemplo, o `ggplot2`.

``` r
library(ggplot2)
ggplot(bra, aes(x = data, y = casosNovos, group = estado, color = regiao)) +
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
