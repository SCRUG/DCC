library(shinydashboard)
library(DT)

#Variables
contenidoOpcion1 <- fluidPage(
  fluidRow(
    DT::dataTableOutput(outputId = "sicop_data_ui")
  )
)

#Interfaz
ui <- (dashboardPage(
  header = dashboardHeader(title = "SICOP"),
  body = dashboardBody(
    tabItems(
      tabItem(tabName = "Opcion1", contenidoOpcion1)
    )
  ),
  sidebar = dashboardSidebar(
    collapsed = FALSE, width = 200,
    sidebarMenu(id = "opciones",
                menuItem(tabName = "Opcion1", text = "Opcion 1", icon = icon("home")))
  )
))
