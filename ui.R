library(shiny)
library(markdown)

shinyUI(navbarPage("PlotR",
       tabPanel("About",
                fluidRow(
                        column(6,
                               includeMarkdown("about.md")
                        )
                        
                )
        ),
        
        
        tabPanel("One Variable",
                 sidebarLayout(
                         sidebarPanel(
                                 fileInput('datafile', 'Upload CSV file',
                                           accept=c('text/csv', 'text/comma-separated-values,
                                                    text/plain')),
                                 #select plot type
                                 uiOutput("plot_type"),
                                 uiOutput("var")
                         ),
                         mainPanel(
                                 plotOutput('one_variable')
                         )
                 )
        ),
       
       tabPanel("Multiple Variables",
                sidebarLayout(
                        sidebarPanel(
                                
                                fileInput('datafile', 'Upload CSV file',
                                          accept=c('text/csv', 'text/comma-separated-values,
                                                   text/plain')),
                                
                                uiOutput("plot_type2"),
                                #y variables
                                uiOutput("xvar"),
                                
                                #x variables
                                uiOutput("yvar"),
                                
                                uiOutput("colflag"),
                                
                                #color
                                conditionalPanel(
                                        condition="input.colflag==true",
                                        uiOutput("color")
                                )
                        ),
                        mainPanel(
                                plotOutput('multi_variable')
                        )
                )
        )
))