# Instalación de programas y herramientas

Lo ideal antes de llegar al día del evento es tener todas las herramientas
en la computadora instaladas y actualizadas. Para esto te recomendamos
verificar lo siguiente:

1. Que tienes una versión de R actualizada. Vamos a trabajar con la version 3.4.3. 
Para verificar la versión que tienes instalada puedes correr en la consola:

    > R.Version()$version.string

La respuesta debería de ser:

    [1] "R version 3.6.1 (2019-07-05)"

Si necesitas actualizar por favor visita la página correspondiente de 
r-project.org:

    https://cloud.r-project.org/

2. Que tienes una version de RStudio Actualizada. 

En RStudio busca la opción en el menu **Help >About RStudio**. Busca si tienes
Versión 1.2.1335 o mayor.
Si es menor instala una versión nueva ya sea con **Help > Check for Updates** o
visitando las páginas de RStudio para bajar una nueva versión compatible con tu sistema:

    https://www.rstudio.com/products/rstudio/download/#download

3. Que tienes los paquetes necesarios 

Para que estes seguro de tener todos los paquetes que vamos a utilizar lo mejor 
es que los instales de antemano. Con las siguientes instrucciones los puedes
instalar todos:

    install.packages(c("tidyverse", "readxl", "lubridate", 
                       "junr"),
                 dependencies = TRUE)
                 
Recuerda que el `tidyverse` se compone de los paquetes `ggplot2`, `dplyr`,
`tidyr`, `readr`, `purrr`, `tibble`, `stringr` y `forcats`. Cuando instalas
el `tidyverse` instalas todos estos paquetes.

Para actualizar los paquetes que ya tienes en el computador, puedes ir a la 
opción en el menú **Packages > update > select all > install** y de esta 
manera tendrás las versiones más recientes.






