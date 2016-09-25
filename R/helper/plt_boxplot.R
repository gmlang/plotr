plt_boxplot = function(dat, xvar, yvar, trans_y) {
        # Plots a boxplot.
        #
        # dat: a data frame that contains xvar and yvar
        # xvar, yvar: strings, names of two continuous variables from dat
        # trans_y: string, names of the variable transformation to be applied
        #       to yvar. Possible values are "log", "log1p", "log10"
        
        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # make plot
        p = ggplot2::ggplot(dat, ggplot2::aes_string(xvar, yvar, group=xvar)) +
                ggplot2::geom_boxplot(fill = blue) + ggplot2::theme_minimal() + 
                ggplot2::guides(fill = FALSE)
        
        # apply comma style to y-axis
        p = scale_axis(p, "y", scale = "comma")
        
        # apply transformation to y-axis
        p = switch(trans_y,
                   none = p,
                   log = scale_axis(p, "y", scale = "log"),
                   log1p = scale_axis(p, "y", scale = "log1p"),
                   log10 = scale_axis(p, "y", scale = "log10")
        )
        
        # return 
        p
}