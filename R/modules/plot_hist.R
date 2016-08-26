# define colors
blue = "#0072B2"

plot_hist_ui = function(id) {
        ns = NS(id)
        tagList(
                plotOutput(ns("hist")),
                sliderInput(ns("bins"), "Number of bins", 1, 50, 20)
        )
}

plot_hist = function(input, output, session, dat, varname) {
        # Plots a histogram of an user-selected variable
        #
        # dat: a data frame
        # varname: a reactive expression when called will return the name of
        #       the variable selected by user. Note we need to use varname()
        #       as that will call it. 
        
        output$hist = renderPlot({
                ggplot2::ggplot(dat, ggplot2::aes_string(x = varname())) + 
                # note: must call varname() with () as it's a reactive function
                        ggplot2::labs(x = varname()) + ggplot2::theme_bw() + 
                        ggplot2::geom_histogram(fill=blue, alpha=.8, 
                                                bins=input$bins, 
                                                position="identity")
        })
}

