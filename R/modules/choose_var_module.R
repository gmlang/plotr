choose_var_ui = function(id) {
        ns = NS(id)
        uiOutput(ns("controls"))
}

choose_var = function(input, output, session, vars) {
        # Returns a reactive expression that will return the name of the user 
        #       selected variable when called.
        #
        # vars: a character vector of variable names
        output$controls = renderUI({
                ns = session$ns
                selectInput(ns("var"), "Select a variable", vars)
        })
        
        reactive({
                req(input$var)
        })
}