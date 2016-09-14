choose_transformation_ui = function(id) {
        ns = NS(id)
        uiOutput(ns("controls"))
}

choose_transformation = function(input, output, session, 
                                 head = "Select a transformation") {
        # Returns a reactive expression that will return the name of the user 
        #       selected variable transformation when called.
        output$controls = renderUI({
                ns = session$ns
                selectInput(ns("var_trans"), label = head, 
                            choices = list("None"="none", "log"="log", 
                                           "log plus 1" = "log1p", "log10"="log10"), 
                            selected = "none")
        })
                
        reactive({
                input$var_trans
        })
}

