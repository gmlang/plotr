plt_hist = function(dat, xvar, trans_x="none", bins) {
        # Plots a histogram
        #
        # dat: a data frame that contains xvar
        # xvar: string, the name of a continuous variable from dat
        # trans_x: string, the name of the variable transformation to be applied
        #       to xvar. Possible values are "log", "log1p", "log10"
        
        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # plot
        p = ggplot2::ggplot(dat, ggplot2::aes_string(x = xvar)) + 
                ggplot2::labs(x = xvar, title="Histogram") + 
                ggplot2::theme_minimal() + 
                ggplot2::geom_histogram(fill=blue, alpha=.8, bins=bins, 
                                        position="identity")
        
        # apply comma style to y-axis
        p = scale_axis(p, "y", scale = "comma")
        
        # apply transformation to x-axis
        switch(trans_x,
               none = p,
               log = scale_axis(p, "x", scale = "log"),
               log1p = scale_axis(p, "x", scale = "log1p"),
               log10 = scale_axis(p, "x", scale = "log10")
        )
}
