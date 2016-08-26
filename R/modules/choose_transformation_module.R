choose_transformation_ui = function(id) {
        ns = NS(id)
        # checkboxInput(ns("log_trans"), "Apply log transformation")        
        selectInput(ns("var_trans"), label = "Select a transformation", 
                    choices = list("None"="none", "log"="log", 
                                   "log plus 1" = "log1p", "log10"="log10"), 
                    selected = "none")
}

choose_transformation = function(input, output, session) {
        reactive({
                input$var_trans
        })
}

