library(tidyverse)
library(readxl)
library(ggmap)
library(rgdal)
library(tmap)
library(sf)
source("limpiar_proyecciones.R", encoding = "UTF-8")
#Descarga y limpieza de las bases de datos
files_polic <- list.files(path = "datos_poderjudicial", "POLICIALES.+xlsx$")
nombres <- str_match(files_polic, "\\d{4}") %>% as.vector()
columnas <- c( "Delito",	"SubDelito",	"Fecha", 	"Victima",	"SubVictima",	"Edad",	"Genero",	"Nacionalidad",	"Provincia",	"Canton","Distrito")
bases_polic <- lapply(files_polic, function(x) read_excel(file.path("datos_poderjudicial", x))) %>%
  setNames(nm = nombres) %>% bind_rows(.id = "ano") %>% as.tibble()
 
# #son todos los nombres iguales
# for(i in seq(1, bases_polic %>% length())){
#   if(i < length(bases_polic)){
#   x<-colnames(bases_polic[[i]]) == colnames(bases_polic[[i+1]])
#   print(x)
#   i = i+1
#   }
# }

# cr_dist <- readOGR("datos_poderjudicial/geo_data/distritos/distritos.shp", encoding = "UTF-8")
# cr_dist <- st_as_sf(as(cr_dist, "SpatialPolygonsDataFrame"))

##########Homogenizar cantones#######
#####################################
#ver cuales cantones en la bases_polic no están la base de cr_dist
setdiff(bases_polic %>% distinct(Canton) %>% unlist() %>% unname,cr_dist$cant_nom1)
#ojo que en base_polic los cantones perdidos viene como "DESCONOCIDO", mejor le pongo NA (SON 423 CASOS)
bases_polic[bases_polic$Canton=="DESCONOCIDO", "Canton"] <- NA_character_

#ahora el inverso
setdiff(cr_dist$cant_nom1, bases_polic %>% distinct(Canton) %>% unlist() %>% unname)
#voy cambiar los cantones en bases_polic
#Vazquez de coronoda
bases_polic[bases_polic$Canton %in% setdiff(bases_polic %>% distinct(Canton) %>% unlist() %>% unname,cr_dist$cant_nom1)[1] , "Canton"] <- setdiff(cr_dist$cant_nom1, bases_polic %>% distinct(Canton) %>% unlist() %>% unname)[2]
#Leon Cortes
bases_polic[bases_polic$Canton %in% setdiff(bases_polic %>% distinct(Canton) %>% unlist() %>% unname,cr_dist$cant_nom1)[2] , "Canton"] <- setdiff(cr_dist$cant_nom1, bases_polic %>% distinct(Canton) %>% unlist() %>% unname)
#Ahora corroboro que todo bien
setdiff(bases_polic %>% distinct(Canton) %>% unlist() %>% unname,cr_dist$cant_nom1)
####################################
####################################

##########Homogenizar distritos######
#####################################
setdiff(bases_polic %>% distinct(Distrito) %>% unlist() %>% unname,cr_dist$dist_nom1)
#ojo que en base_polic los distritos perdidos viene como "DESCONOCIDO", mejor le pongo
# con solo esto se identifican 34  distritos distintos, esto quedará para después. Po ahora
# solo se hará por cantón.
# igual voy a quitar los Distritos desconocidos por NA
bases_polic[bases_polic$Distrito=="DESCONOCIDO", "Distrito"] <- NA_character_

save(bases_polic, file = "datos_poderjudicial/base_polic.Rdata")
##########queda pendiente############
#####################################
#####################################

#delitos por cantón
delitos_canton <- bases_polic %>% filter(!is.na(Canton))%>% group_by(ano, Provincia, Canton) %>% summarise(delitos = n()) 

#ver si pegan los cantones
setequal(cr_dist$cant_nom1 %>% as.character(), delitos_canton$Canton %>% unique())
#en efecto se pueden pegar


delitos_canton <- proyecciones_polygonos %>% gather(key = "ano", value = "poblacion", str_subset(colnames(.), "proyec_poblac")) %>% mutate(ano = str_match(ano, "\\d{4}") %>% as.vector()) %>% filter(ano %in% 2015:2019)%>% left_join(delitos_canton, by = c("ano" = "ano", "cant_nom1" = "Canton") )





