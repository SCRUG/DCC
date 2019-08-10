library(readxl)
library(sf)
#importar mapa
 cr_dist <- readOGR("datos_poderjudicial/geo_data/distritos/distritos.shp", encoding = "UTF-8")
 cr_dist <- st_as_sf(as(cr_dist, "SpatialPolygonsDataFrame"))


#importar, limpiar y pegar
files_proy <- list.files(path = "datos_poderjudicial", "^Proyecc.+xlsx$")
nombres_proy <- str_match(files_proy, "\\d{4}") %>% as.vector()
columnas_proy <- c("canton", "poblacion")
proyecciones <- lapply(files_proy, function(x) read_excel(file.path("datos_poderjudicial", x), skip = 4 ,col_names = columnas_proy))%>%
  setNames(nm = nombres_proy) %>% bind_rows(.id = "ano") %>% as.tibble()

proyecciones <-  proyecciones %>% filter(!canton == "Total") %>% separate(col = canton, into = c("cant_id", "nombre_canton"), sep = ":\\s") 

save(proyecciones, file="datos_poderjudicial/proyecciones.R")

proyecciones_wide <- proyecciones %>% mutate(ano = paste(ano, "proyec_poblac" , sep = "-")) %>% spread(key = ano, value = poblacion) %>% mutate(cant_id = as.numeric(cant_id))
save(proyecciones_wide, file="datos_poderjudicial/proyecciones_wide.R")
#pegar con lo poligonos
setdiff( proyecciones_wide$cant_id, cr_dist$cant_id)
#el canton 216 (rio frio de alajuela) no viene en la base de proyecciones, ni idea porqué.


proyecciones_polygonos <- left_join(cr_dist, proyecciones_wide, by = c("cant_id"))

