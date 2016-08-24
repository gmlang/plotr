library(shiny)

# load modules
modules_path = "R/modules"
for (fname in list.files(modules_path))
        source(file.path(modules_path, fname))

# UI
shinyUI(navbarPage("PlotR",
                tabPanel("Upload Data", 
                         sidebarLayout(
                                 sidebarPanel(
                                         upload_ui("datafile")
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
                                         plot_hist_ui("bin_num")
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
                                         
                                 ),
                                 mainPanel(
                                         
                                 )
                         )
                )
        
                
                
                           
        )
)