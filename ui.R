# UI
navbarPage(title=div(a(href="https://cabaceo.com",
                       img(src="logo.png", id = "logo", align = "left",
                           width=150, style = "margin:-40px 20px 2px 2px")), 
                     "PlotR"),
           windowTitle = "PlotR",
           theme = "darkly2.css", 

           tabPanel("Upload Data", 
                    sidebarLayout(
                            sidebarPanel(
                                    upload_ui("datafile"),
                                    br(),
                                    p("Made by", 
                                      a("Cabaceo LLC", href="https://cabaceo.com", 
                                        target="_blank")),
                                    # insert google ads
                                    tags$script(async="async", src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"),
                                    includeHTML("www/google-ads-size-auto.html"),
                                    tags$script("(adsbygoogle = window.adsbygoogle || []).push({});")
                                    ),
                            mainPanel(
                                    verbatimTextOutput("datastruct"),
                                    dataTableOutput("first100rows")
                                    )
                            )
                    ),
           
           tabPanel("Continuous",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("varname_con"),
                                    choose_transformation_ui("var_trans"),
                                    br(),
                                    p("Made by", 
                                      a("Cabaceo LLC", href="https://cabaceo.com", 
                                        target="_blank"))
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
           
           tabPanel("Categorical",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("varname_cat"),
                                    br(),
                                    p("Made by", 
                                      a("Cabaceo LLC", href="https://cabaceo.com", 
                                        target="_blank"))
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
           
           tabPanel("Continuous vs. Continuous",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("con_xvar"),
                                    choose_var_ui("con_yvar"),
                                    choose_var_ui("fillby_var"),
                                    choose_transformation_ui("trans_xvar"),
                                    choose_transformation_ui("trans_yvar"),
                                    br(),
                                    p("Made by", 
                                      a("Cabaceo LLC", href="https://cabaceo.com", 
                                        target="_blank"))
                                    ),
                            mainPanel(
                                    plot_scatter_ui("scatterplot")
                                    )
                            )
                    ),

           tabPanel("Continuous vs. Categorical",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("cat_xvar"),
                                    choose_var_ui("con_yvar2"),
                                    choose_transformation_ui("trans_yvar2"),
                                    br(),
                                    p("Made by", 
                                      a("Cabaceo LLC", href="https://cabaceo.com", 
                                        target="_blank"))
                                    ),
                            mainPanel(
                                    plot_boxplot_ui("boxplot")
                                    )
                            )
                    ),

           tabPanel("Categorical vs. Categorical",
                    sidebarLayout(
                            sidebarPanel(
                                    choose_var_ui("cat_xvar2"),
                                    choose_var_ui("cat_yvar2"),
                                    br(),
                                    p("Made by", 
                                      a("Cabaceo LLC", href="https://cabaceo.com", 
                                        target="_blank"))
                                    ),
                            mainPanel(
                                    plot_mosaic_ui("mosaic")
                                    )
                            )
                    )
           
           
           )
