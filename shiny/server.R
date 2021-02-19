
library(shiny)

shinyServer(function(input, output,session) {
  
  output$place.v.regijah <- renderPlot(
    
    letne.place %>% filter(STATISTICNA.REGIJA == input$Regija) 
    
    %>% ggplot(aes(x = POVPRECNA.LETNA.PLACA, y = substr(SKD.DEJAVNOST,1,1))) + geom_col() + 
      ylab('Panoga')+
      xlab('Plača')+
      coord_flip()+
      theme(plot.title = element_text(hjust = 0.5)) + 
      
      ggtitle(paste('Neto povprečna letna plača v regiji -', input$Regija, 'za vsako panogo')),
    
    height = 400, width = 500
    
  )
  
  
  output$place.po.panogah <- renderPlot(
    
    letne.place %>% filter(SKD.DEJAVNOST == input$Panoga) 
    
    %>% ggplot(aes(x = POVPRECNA.LETNA.PLACA, y = STATISTICNA.REGIJA)) + geom_col() + 
      ylab('Regija')+
      xlab('Plača')+
      coord_flip()+
      theme(plot.title = element_text(hjust = 0.5)) + 
      theme(axis.text.x = element_text(size = 6, angle = 45, vjust = 0.5, hjust=1))+
      
      ggtitle(paste('Neto povprečna letna plača za panogo -', input$Panoga, 'v posamezni regiji')),
    
    height = 400, width = 500
    
  )
  
  output$mesecne.place <- renderPlot(
    
    uvozi.place %>% filter(STATISTICNA.REGIJA == input$Regija) 
    
    %>% ggplot(aes(x = NETO.MESECNA.PLACA, y = substr(SKD.DEJAVNOST,1,1))) + geom_col() + 
      ylab('Panoga')+
      xlab('Plača')+
      coord_flip()+
      theme(plot.title = element_text(hjust = 0.5)) + 
      
      ggtitle(paste(' v regiji-', input$Regija, 'za vsako panogo, pa še en input za leto')),
    
    height = 400, width = 500
    
  )
  
  
  

})