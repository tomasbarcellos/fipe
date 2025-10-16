
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fipe

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

Por enquanto só é possível instalar o pacote pelo github.

``` r
remotes::install_github("tomasbarcellos/fipe")
```

O objetivo de fipe é criar uma forma fácil de acessar os dados de preços
de carros novos pelo R.

Um exemplo pode ser visto abaixo

``` r
library(fipe)
library(dplyr)

q3_2021 <- tabela_fipe(2021, "audi", "Q3") %>% 
  filter(!is.na(Valor))
q3_2021 %>% 
  glimpse()
#> Rows: 3
#> Columns: 13
#> $ codigo           <chr> NA, NA, NA
#> $ erro             <chr> NA, NA, NA
#> $ Valor            <chr> "R$ 282.327,00", "R$ 577.242,00", "R$ 607.242,00"
#> $ Marca            <chr> "Audi", "Audi", "Audi"
#> $ Modelo           <chr> "Q3 Black S Line 1.4 TFSI S-tronic", "RS Q3 2.5 TFSI …
#> $ AnoModelo        <int> 32000, 32000, 32000
#> $ Combustivel      <chr> "Gasolina", "Gasolina", "Gasolina"
#> $ CodigoFipe       <chr> "008267-8", "008193-0", "008265-1"
#> $ MesReferencia    <chr> "dezembro de 2021 ", "dezembro de 2021 ", "dezembro d…
#> $ Autenticacao     <chr> "n0b171wwbhp", "044bgnmf5yp", "189q4m56jvp"
#> $ TipoVeiculo      <int> 1, 1, 1
#> $ SiglaCombustivel <chr> "G", "G", "G"
#> $ DataConsulta     <chr> "quinta-feira, 16 de outubro de 2025 01:19", "quinta-…
```

O pacote também inclui uma tabela com precos dos modelos mais vendidos
dos últimos 22 anos (2003-2024).

``` r
precos_fipe %>% 
  glimpse()
#> Rows: 1,573
#> Columns: 4
#> Groups: montadora, modelo [209]
#> $ montadora <chr> "audi", "audi", "audi", "audi", "bmw", "bmw", "byd", "byd", …
#> $ modelo    <chr> "a3", "a3", "a3", "a3", "x1", "x1", "dolphin", "dolphin", "d…
#> $ ano       <int> 2003, 2004, 2005, 2006, 2022, 2023, 2023, 2024, 2024, 2024, …
#> $ preco     <dbl> 49239, 52329, 61664, 64991, 284474, 301838, 149897, 117637, …
```
