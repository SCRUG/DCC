library(DT)
library(ggplot2)

server <- function(input, output, session){
  output$sicop_data_ui <- DT::renderDataTable({
    DT::datatable(data = sicop_visualizacion1, options=list(pageLenght = 15))
  })
  
  output$grafico_visualizacion_usd <- renderPlot({
    datos_usd <- sicop_visualizacion1 %>% 
      filter(Moneda == "USD")
    datos_usd$MontoTotal <- datos_usd$MontoTotal/1000000
    
    ggplot(datos_usd) +
      geom_bar(aes(x = `Clasificación objeto`, weight = MontoTotal)) +
      xlab("Clasificacion") +
      ylab("Monto en Millones de USD") +
      coord_flip()
  })
  
  output$grafico_visualizacion_crc <- renderPlot({
    datos_crc <- sicop_visualizacion1 %>% 
      filter(Moneda == "CRC")
    datos_crc$MontoTotal <- datos_crc$MontoTotal/1000000000000
      
    ggplot(datos_crc) +
      geom_bar(aes(x = `Clasificación objeto`, weight = MontoTotal)) +
      xlab("Clasificacion") +
      ylab("Monto en Billones de CRC") +
      coord_flip()
  })
}