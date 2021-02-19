library(shiny)

shinyUI(fluidPage(
  
  titlePanel("Neto povprečne letne plače v regijah in po panogah"),
  
  tabsetPanel(
    
    tabPanel("Povprečne letne plače po regijah",
             sidebarPanel(
               selectInput(inputId = "Regija",
                           label = "Izberi regijo",
                           choices = unique(letne.place$STATISTICNA.REGIJA))
               
             ),
             mainPanel(plotOutput("place.v.regijah"))
    ),
    
    tabPanel("Povprečne letne plače po panogah",
             sidebarPanel(
               selectInput(inputId = "Panoga",
                           label = "Izberi panogo",
                           choices = unique(letne.place$SKD.DEJAVNOST))
               
             ),
             mainPanel(plotOutput("place.po.panogah"))
             
    ),
    
    
    
    tabPanel("Mesečne plače v regijah po panogah",
             sidebarPanel(
               selectInput(inputId = "regija",
                           label = "Izberi regijo",
                           choices = unique(uvozi.place$STATISTICNA.REGIJA),
                           dateInput('datum', 'Izberi leto' ))
               
             ),
             mainPanel(plotOutput("mesecne.place"))
             )
    
  )))