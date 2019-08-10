library(readr)
library(dplyr)
library(formattable)
library(ggplot2)

options(scipen = 16)

sicop_data <- read_delim('datos/sicop.csv', ';')

# Agrupar proveedores por monton ordenados decendentemente
sicop_visualizacion1 <- sicop_data %>% 
  select(Adjudicatario, `Clasificación objeto`, Moneda, Monto) %>% 
  group_by(Adjudicatario, `Clasificación objeto`, Moneda) %>% 
  summarise(MontoTotal = sum(Monto)) %>% 
  arrange(desc(MontoTotal))
