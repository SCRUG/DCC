library(shinydashboard)
library(DT)

#Variables
contenidoOpcion1 <- fluidPage(
  fluidRow(
    DT::dataTableOutput(outputId = "sicop_data_ui")
  )
)

contenidoOpcion2 <- fluidPage(
  fluidRow(
    box(width = "100%", title = "Monto Total en Dolares de compras por Clasificacion", solidHeader = TRUE, status = "primary",
        plotOutput("grafico_visualizacion_usd"))
  )
)

contenidoOpcion3 <- fluidPage(
  fluidRow(
    box(width = "100%", title = "Monto Total en Colones de compras por Clasificacion", solidHeader = TRUE, status = "primary",
        plotOutput("grafico_visualizacion_crc"))
  )
)

#Interfaz
ui <- (dashboardPage(
  header = dashboardHeader(title = "SICOP"),
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "Opcion1", contenidoOpcion1),
      tabItem(tabName = "Compras_USD", contenidoOpcion2),
      tabItem(tabName = "Compras_CRC", contenidoOpcion3)
    )
  ),
  sidebar = dashboardSidebar(
    collapsed = FALSE, width = 200,
    sidebarMenu(id = "opciones",
                menuItem(tabName = "Opcion1", text = "Datos", icon = icon("home")),
                menuItem(tabName = "Compras_USD", text = "Compras USD", icon = icon("home")),
                menuItem(tabName = "Compras_CRC", text = "Compras CRC", icon = icon("home")))
  )
))
