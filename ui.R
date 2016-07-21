library(shiny)

shinyUI(fluidPage(
        # Header or Title Panel 
        titlePanel(title = h4("PlotR", align="center")),
        
        # Sidebar panel
        sidebarPanel(
      
                fileInput('datafile', 'Upload CSV file',
                          accept=c('text/csv', 'text/comma-separated-values,text/plain')),
                uiOutput("x")
                
        ),
        # Main Panel
        mainPanel(
                tabsetPanel(type="tab", 
                            tabPanel("Distribution",plotOutput('plot')),
                            tabPanel("Two Variables", verbatimTextOutput("")),
                            tabPanel("Three Variables", tableOutput("")),
                            tabPanel("Change Scales", plotOutput(""))
                )
      
        )
        
))