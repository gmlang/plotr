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
        
                tabPanel("Single Continuous Variable",
                         sidebarLayout(
                                 sidebarPanel(
                                         choose_var_ui("varname_con"),
                                         choose_transformation_ui("var_trans")
                                 ),
                                 mainPanel(
                                         plot_hist_ui("histogram"),
                                         verbatimTextOutput("summary")
                                 )
                         )
                ),

                tabPanel("Single Categorical Variable",
                         sidebarLayout(
                                 sidebarPanel(
                                         choose_var_ui("varname_cat")
                                 ),
                                 mainPanel(
                                         plot_barchart_ui("barchart"),
                                         verbatimTextOutput("tbl_freq_pct")
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