library(shiny)

output$panoge.v.regijah <- renderPlot(
  letne.place %>% filter(STATISTICNA.REGIJA == input$Regija) 
  %>% ggplot(aes(x = POVPRECNA.LETNA.PLACA, y = SKD.DEJAVNOST)) + geom_col() + 
    theme(plot.title = element_text(hjust = 0.5)) + 
    ggtitle(paste('v regiji -', input$Regija)),
  height = 400, width = 500
)


