blue = "#0072B2" # color-blind friendly blue

plot_hist_ui = function(id) {
        ns = NS(id)
        tagList(
                plotOutput(ns("hist")),
                sliderInput(ns("bins"), "Number of bins", 1, 50, 20)
        )
}

plot_hist = function(input, output, session, dat, varname, trans_x) {
        # Plots a histogram of an user-selected variable
        #
        # dat: a data frame
        # varname: a reactive expression when called will return the name of
        #       the variable selected by user. Need to use varname() to call it.
        # trans_x: a reactive expression when called will return the name of 
        #       the variable transformation selected by user. Need to use 
        #       trans_x() to call it.
        output$hist = renderPlot({
                p = ggplot2::ggplot(dat, ggplot2::aes_string(x = varname())) + 
                # note: must call varname() with () as it's a reactive function
                        ggplot2::labs(x = varname()) + ggplot2::theme_bw() + 
                        ggplot2::geom_histogram(fill=blue, alpha=.8, 
                                                bins=input$bins, 
                                                position="identity")
                
                # apply comma to y-axis
                p = scale_axis(p, "y", scale = "comma")
                
                # apply transformation to x-axis
                p = switch(trans_x(),
                           none = p,
                           log = scale_axis(p, "x", scale = "log"),
                           log1p = scale_axis(p, "x", scale = "log1p"),
                           log10 = scale_axis(p, "x", scale = "log10"))
                
                # return
                p
        })
}

