library(shiny)

shinyUI(fluidPage(
        # Header or Title Panel 
        titlePanel(title = h4("PlotR", align="center")),
        
        # Sidebar panel
        sidebarPanel(
      
                fileInput('datafile', 'Upload CSV file',
                          accept=c('text/csv', 'text/comma-separated-values,text/plain')),
                uiOutput("var"),
                
                selectInput("plot_type", "Plot Type",
                            c("Histogram", "QQ plot", "Barplot of frequency")
                ),
                
                uiOutput("getPlot")
                
        ),
        # Main Panel
        mainPanel(
                tabsetPanel(type="tab", 
                            tabPanel("One Variable",plotOutput('plot')),
                            tabPanel("Two Variables", plotOutput("")),
                            tabPanel("Three Variables", plotOutput("")),
                            tabPanel("Change Scales", plotOutput(""))
                )
      
        )
        
))