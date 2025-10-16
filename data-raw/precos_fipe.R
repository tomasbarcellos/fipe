library(tidyverse)
arq_fipe <- dir("dados/", full.names = TRUE)

ler_dados_fipe <- function(arquivo) {
  partes <- arquivo %>%
    str_remove_all("dados/+|\\.rds") %>%
    str_split("_") %>%
    magrittr::extract2(1)

  dados <- readRDS(arquivo)
  resp_vazia <- tibble(montadora = partes[1],
                       modelo = partes[2],
                       ano = as.integer(partes[3]),
                       marca = NA_character_,
                       modelo_fipe = NA_character_,
                       codigo_fipe = NA_character_,
                       mes_referencia = NA_character_,
                       data_consulta = NA_character_,
                       preco = NA_real_)

  if (ncol(dados) == 0) {
    return(resp_vazia)
  }

  if ("erro" %in% names(dados)) {
    # as vezes há requisições com erros em meio a boas requisições
    if (!any(is.na(dados$codigo))) {
      return(resp_vazia)
    }
  }

  dados %>%
    transmute(montadora = partes[1],
              modelo = partes[2],
              ano = as.integer(partes[3]),
              marca = Marca, modelo_fipe = Modelo,
              codigo_fipe = CodigoFipe,
              mes_referencia = MesReferencia,
              data_consulta = DataConsulta,
              preco = Valor %>%
                str_remove("R\\$ ") %>%
                str_remove_all("\\.") %>%
                str_replace(",", ".") %>%
                as.numeric())

}

precos_fipe <- arq_fipe %>%
  # head(50) %>%
  map_df(ler_dados_fipe) %>%
  filter(!is.na(preco)) %>%
  group_by(montadora, modelo, ano) %>%
  summarise(preco = min(preco)) %>%
  mutate(modelo = modelo %>%
           str_replace("\\bsed$", "sedan") %>%
           str_replace("\\bclass$", "classic"))
usethis::use_data(precos_fipe)
