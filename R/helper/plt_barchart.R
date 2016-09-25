plt_barchart = function(dat) {
        # Plots a bar chart.
        #
        # dat: data frame with a xvar and vars named "count" and "percent"
        
        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # initialize var
        yvar = "count" # fixed, same for all input data
        xvar = names(dat)[!grepl("count|percent", names(dat))]
        
        # draw barplot
        p = ggplot2::ggplot(dat, ggplot2::aes_string(x=xvar, y=yvar)) +
                ggplot2::geom_bar(stat = "identity", fill = blue) +
                ggplot2::labs(x = xvar, y = yvar) + ggplot2::theme_minimal()
        
        # apply comma style to y-axis
        scale_axis(p, "y", scale = "comma")
}