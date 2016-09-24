# UI
navbarPage("PlotR", theme = "darkly1.css", 
           
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
                                    fluidRow(column(5, 
                                                    plot_hist_ui("histogram"), br(),
                                                    verbatimTextOutput("summary")),
                                             column(5, offset = 1,
                                                    br(), br(),br(), br(),br(),
                                                    plot_qqnorm_ui("qqplot"))
                                             )
                                    )
                            )
                    ),
           
           tabPanel("Single Categorical Variable",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("varname_cat")
                                    ),
                            mainPanel(
                                    fluidRow(column(5, 
                                                    plot_barchart_ui("barchart")
                                                    ),
                                             column(5, offset = 1, 
                                                    verbatimTextOutput("tbl_freq_pct")
                                                    )
                                             )
                                    )
                            )
                    ),
           
           tabPanel("Continuous vs. Continuous Variables",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("con_xvar"),
                                    choose_var_ui("con_yvar"),
                                    choose_var_ui("fillby_var"),
                                    choose_transformation_ui("trans_xvar"),
                                    choose_transformation_ui("trans_yvar")
                                    ),
                            mainPanel(
                                    plot_scatter_ui("scatterplot")
                                    )
                            )
                    )
           
           
           )
