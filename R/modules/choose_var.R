choose_var_ui = function(id) {
        ns = NS(id)
        uiOutput(ns("controls"))
}

choose_var = function(input, output, session, dat) {
        output$controls = renderUI({
                ns = session$ns
                selectInput(ns("var"), "Select a variable", names(dat))
        })
        
        reactive({
                req(input$var)
                list(varname = input$var, vec = dat[[input$var]])
        })
}