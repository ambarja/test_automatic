library(tidyverse)
library(vroom)

download.file(
  url = "https://cloud.minsa.gob.pe/s/Y8w3wHsEdYQSZRp/download",
  destfile = "data/casos_positivos.csv"
)

vacunas <- vroom(
  "data/casos_positivos.csv",
  col_types = cols(
    FECHA_CORTE = col_date(format = "%Y%m%d"),
    UUID = col_character(),
    DEPARTAMENTO = col_character(),
    PROVINCIA = col_character(),
    DISTRITO = col_character(),
    METODODX = col_character(),
    EDAD = col_double(),
    SEXO = col_factor(),
    FECHA_RESULTADO = col_date(format = "%Y%m%d")
  )
) %>%
  mutate(
    rango_edad = cut(EDAD,
      c(seq(0, 80, 20), 130),
      include.lowest = TRUE,
      right = FALSE,
      labels = c(
        "0-19",
        "20-39",
        "40-59",
        "60-79",
        "80+"
      ), ordered_result = TRUE
    )
  )

saveRDS(
  vacunas,
  file = "data/casos_positivos.rds"
)
