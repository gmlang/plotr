plt_barchart = function(dat, xvar) {
        # Plots a bar chart.
        #
        # dat: a data frame that contains xvar and a variable named "count"
        # xvar: the name of the variable on the x-axis, has discrete levels
        
        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # initialize var
        yvar = "count" # fixed, same for all input data
        
        # draw barplot
        ggplot2::ggplot(dat, ggplot2::aes_string(x=xvar, y=yvar)) +
                ggplot2::geom_bar(stat = "identity", fill = blue) +
                ggplot2::labs(x = xvar, y = yvar) + ggplot2::theme_bw() 
}