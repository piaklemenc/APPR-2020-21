
library(shiny)

shinyServer(function(input, output,session) {
  
  output$place.v.regijah <- renderPlot(
    letne.place %>% filter(STATISTICNA.REGIJA == input$Regija) %>% ggplot(aes(y = POVPRECNA.LETNA.PLACA, x = SKD.DEJAVNOST)) + geom_col() + 
      theme(plot.title = element_text(hjust = 0.5)) +
      aes(str_wrap(SKD.DEJAVNOST, 30), POVPRECNA.LETNA.PLACA) +   coord_flip()+
      ylab('Plača')+
      xlab('Panoga')+
      ggtitle(paste('Neto povprečna letna plača v regiji -', input$Regija, '\n za vsako panogo')),
    height = 700, width = 580
  )
  
  
  output$place.po.panogah <- renderPlot(
    letne.place %>% filter(SKD.DEJAVNOST == input$Panoga) 
    %>% ggplot(aes(x = POVPRECNA.LETNA.PLACA, y = STATISTICNA.REGIJA)) + geom_col() + 
      aes(str_wrap(STATISTICNA.REGIJA, 30), POVPRECNA.LETNA.PLACA) + 
      xlab('Regija')+
      ylab('Plača')+
      coord_flip()+
      theme(plot.title = element_text(hjust = 0.5)) + 
      ggtitle(paste('Neto povprečna letna plača za panogo - \n', input$Panoga,'\n v posamezni regiji')),
    height = 700, width = 580
  )
  
  
  output$mesecne.place <- renderPlot(
    uvozi.place %>% filter(STATISTICNA.REGIJA == input$regija, MESEC == input$datum) 
    %>% ggplot(aes(x = NETO.MESECNA.PLACA, y = SKD.DEJAVNOST)) + geom_col() + 
      aes(str_wrap(SKD.DEJAVNOST, 30), NETO.MESECNA.PLACA) + 
      xlab('Panoga')+
      ylab('Plača')+
      coord_flip()+
      theme(plot.title = element_text(hjust = 0.5)) + 
      ggtitle(paste(' Mesečne plače v regiji - ', input$regija, '\n za vsako panogo v letu-mesecu', input$datum)),
    height = 700, width =580
  )


})