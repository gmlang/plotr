library(shiny)

shinyUI(fluidPage(
          # Header or Title Panel 
          titlePanel(title = h4("PlotR", align="center")),
          sidebarLayout(
            # Sidebar panel
            sidebarPanel(
              
              sliderInput(inputId = "num", 
                          label = "Choose a number", 
                          value = 25, min = 1, max = 100)
              ),
            
            # Main Panel
            mainPanel(
              tabsetPanel(type="tab", 
                          tabPanel("Distribution",plotOutput("hist")),
                          tabPanel("Two Variables", verbatimTextOutput("")),
                          tabPanel("Three Variables", tableOutput("")),
                          tabPanel("Change Scales", plotOutput(""))
                          
              )
              
            )
            
          )
        )  
)