library(shiny)

for (fname in list.files("R/modules")) 
    source(file.path("R/modules", fname))

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
                             choose_var_ui("varname"),
                             plot_hist_input("bin_num")
                         ),
                         mainPanel(
                             verbatimTextOutput("summary"),
                             plotOutput("hist")
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