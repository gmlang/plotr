choose_var_ui = function(id) {
        ns = NS(id)
        uiOutput(ns("controls"))
}

choose_var = function(input, output, session, dat) {
        # Returns the name of the variable that user selected
        #
        # dat: a data frame
        
        output$controls = renderUI({
                ns = session$ns
                selectInput(ns("var"), "Select a variable", names(dat))
        })
        
        reactive({
                req(input$var)
        })
}