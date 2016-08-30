blue = "#0072B2" # color-blind friendly blue

plot_barchart_ui = function(id) {
        ns = NS(id)
        plotOutput(ns("barchart"))
} 

plot_barchart = function(input, output, session, dat, xvar) {
        # Plots a bar chart of an user-selected variable.
        #
        # dat: a reactive expression when called will return a data frame. Must
        #       call it using dat(). The returned data frame must contain a variable 
        #       named "count" and the variable name returned by xvar().
        # xvar: a reactive expression when called will return the name of an
        #       user selected variable. Must call it using xvar()
        output$barchart = renderPlot({
                # initialize var
                yvar = "count" # fixed, same for all input data
                
                # draw barplot
                ggplot2::ggplot(dat(), ggplot2::aes_string(x=xvar(), y=yvar)) +
                ggplot2::geom_bar(stat = "identity", fill = blue) +
                ggplot2::labs(x = xvar(), y = yvar) + ggplot2::theme_bw() +
                ggplot2::guides(fill = ggplot2::guide_legend(reverse=TRUE))
        })
}

