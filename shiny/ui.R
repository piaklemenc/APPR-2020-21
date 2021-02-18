library(shiny)

shinyUI(fluidPage(
  
  titlePanel("naslov1"),
  
  tabsetPanel(
    
    tabPanel("naslov2",
             sidebarPanel(
               selectInput(inputId = "Regija",
                           label = "Izberi regijo",
                           choices = unique(letne.place$STATISTICNA.REGIJA))
               
             ),
             mainPanel(plotOutput("panoge.v.regijah"))
    ))))