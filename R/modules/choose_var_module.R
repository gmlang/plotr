choose_var_ui = function(id) {
        ns = NS(id)
        uiOutput(ns("controls"))
}

choose_var = function(input, output, session, head="Select a variable", vars,
                      init_var_idx=1) {
        # Returns a reactive expression that will return the name of the user 
        #       selected variable when called.
        #
        # head: string, section header.
        # vars: a reactive expression that will return a character vector of 
        #       variable names when called.
        output$controls = renderUI({
                ns = session$ns
                selectInput(ns("var"), head, vars(), vars()[init_var_idx])
        })
        
        reactive({
                req(input$var)
        })
}