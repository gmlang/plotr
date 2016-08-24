plot_hist_ui = function(id) {
        ns = NS(id)
        sliderInput(ns("bins"), "Number of bins", 1, 50, 20)
}

plot_hist = function(input, output, session, x, ...) {
        # x: a reactive expression when called will return a numeric vector
        
        reactive({
                hist(x()$vec, breaks = input$bins, main=x()$varname,
                     xlab = x()$varname)
                # note: must call x() as x is a reactive expression
        })
}