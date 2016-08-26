# define colors
blue = "#0072B2"

plot_barchart_ui = function(id) {
        ns = NS(id)
        
        plotOutput(ns("barchart"))
} 


plot_barchart = function(input, output, session, dat, varname) {
        
        output$barchart = renderPlot({
                
                # initialize var
                yvar = "count" # fixed, same for all input data
                
                # draw barplot
                ggplot2::ggplot(dat(), 
                                ggplot2::aes_string(x = varname(), y = yvar)) +
                ggplot2::geom_bar(stat = "identity", fill = blue) +
                ggplot2::labs(x = varname(), y = yvar) +
                ggplot2::theme_bw() +
                ggplot2::guides(fill = ggplot2::guide_legend(reverse=TRUE))
        })
}

