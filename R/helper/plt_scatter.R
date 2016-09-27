plt_scatter = function(dat, xvar, yvar, fillby="None", trans_x="none", trans_y="none") {
        # Plots a scatter plot.
        #
        # dat: a data frame that contains xvar and yvar
        # xvar, yvar: strings, names of two continuous variables from dat
        # fillby: string, name of categorical var from dat, used to color the points
        # trans_x, trans_y: strings, names of the variable transformation to be applied
        #       to xvar and yvar. Possible values are "log", "log1p", "log10"
        
        # define color-blind friendly blue
        blue = "#0072B2" 
        
        # define point size and transparency
        pt_alpha = 0.7
        pt_size = 2

        # plot scatter color by a third variable or blue
        if (fillby == "None") {
                p = ggplot2::ggplot(dat, ggplot2::aes_string(xvar, yvar)) + 
                        ggplot2::geom_jitter(color=blue, alpha=pt_alpha, size=pt_size)
        } else {
                # make sure fillby is factor
                dat[[fillby]] = factor(dat[[fillby]])
                p = ggplot2::ggplot(dat, ggplot2::aes_string(xvar, yvar, color=fillby)) + 
                        ggplot2::geom_jitter(alpha=pt_alpha, size=pt_size)
        }

        # # add line
        # p = p + ggplot2::geom_smooth(method=lm, se=F, size=1) 
        
        # apply theme
        p = p + ggplot2::theme_minimal() + ggplot2::theme(legend.position="bottom")
        
        # apply comma style to both axes
        p = scale_axis(p, "y", scale = "comma")
        p = scale_axis(p, "x", scale = "comma")
        
        # apply transformation to x-axis
        p = switch(trans_x,
               none = p,
               log = scale_axis(p, "x", scale = "log"),
               log1p = scale_axis(p, "x", scale = "log1p"),
               log10 = scale_axis(p, "x", scale = "log10")
        )
        
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