library(DT)

server <- function(input, output, session){
  output$sicop_data_ui <- DT::renderDataTable({
    DT::datatable(data = sicop_data, options=list(pageLenght = 15))
  })
}