plt_qqnorm = function(vec) {
        # Plots a QQ plot to check normality.
        #
        # vec: a numeric vector of sample values
        
        # define color-blind friendly color
        blue = "#0072B2" 
        
        # calc sample quantile
        y = quantile(vec[!is.na(vec)], c(0.25, 0.75))
        
        # calc quantiles of a normal distribution
        x = qnorm(c(0.25, 0.75))
        
        # calc the slope and the intercept of the line
        slope = diff(y) / diff(x)
        intercept = y[1L] - slope * x[1L]
        
        # plot
        ggplot2::ggplot(data.frame(ids = vec), ggplot2::aes(sample = ids)) + 
                ggplot2::stat_qq() + ggplot2::ggtitle("Q-Q Plot") + ggplot2::theme_bw() + 
                ggplot2::geom_abline(slope = slope, intercept = intercept,
                                     color = blue, linetype = "dashed", size=1)
}
