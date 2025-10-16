library(rvest)
link <- "https://veiculos.fipe.org.br/#carro-comum"
pag_live <- read_html_live(link)
cod_anos <- pag_live %>%
  html_nodes("option") %>%
  html_attr("value")

datas <- pag_live %>%
  html_nodes("option") %>%
  html_text() %>%
  stringr::str_c("/01") %>%
  lubridate::myd(locale = "pt_BR.UTF-8")

tbl_ano <- tibble::tibble(
  data = datas,
  valor = cod_anos
) %>%
  dplyr::filter(lubridate::month(data) == 12) %>%
  dplyr::mutate(ano = lubridate::year(data))

usethis::use_data(tbl_ano, overwrite = TRUE)

