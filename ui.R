library(shiny)

source("R/modules/upload_module.R")

shinyUI(navbarPage("PlotR",
       tabPanel("Upload Data",
                sidebarLayout(
                    sidebarPanel(
                        upload_input("datafile")
                    ),
                    mainPanel(
                        verbatimTextOutput("datastruct"),
                        dataTableOutput("first100rows")
                    )
                )
        ),
        
        
        tabPanel("One Variable",
                 sidebarLayout(
                         sidebarPanel(
                                 #select plot type
                                 uiOutput("plot_type"),
                                 uiOutput("var"),
                                 uiOutput("scale"),
                                 uiOutput("getPlot")
                         ),
                         mainPanel(
                                 plotOutput('one_variable')
                         )
                 )
        ),
       
       tabPanel("Multiple Variables",
                sidebarLayout(
                        sidebarPanel(
                                

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
                                ),
                                #change xscale
                                uiOutput("xscale"),
                                
                                #change yscale
                                uiOutput("yscale"),
                                
                                uiOutput("getPlot2")
                        ),
                        mainPanel(
                                plotOutput('multi_variable')
                        )
                )
        )
))