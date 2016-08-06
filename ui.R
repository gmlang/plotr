library(shiny)

shinyUI(fluidPage(
        # Header or Title Panel 
        titlePanel(title = h4("PlotR", align="center")),
        
        # Sidebar panel
        sidebarPanel(
      
                fileInput('datafile', 'Upload CSV file',
                          accept=c('text/csv', 'text/comma-separated-values,text/plain')),
                
                #y variables
                uiOutput("yvar"),
                
                #x variables
                uiOutput("xvar"),
                
                uiOutput("colflag"),
                
                #color
                conditionalPanel(
                        condition="input.colflag==true",
                        uiOutput("color")
                ),
                
                #select plot type
                uiOutput("plot_type"),
                
                #change xscale
                uiOutput("xscale"),
                
                #change yscale
                uiOutput("yscale"),
                
                uiOutput("getPlot")
                
        ),
        # Main Panel
        mainPanel(
              plotOutput('plot')
        )
        
))