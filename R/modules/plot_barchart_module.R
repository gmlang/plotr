plot_barchart_ui = function(id) {
        ns = NS(id)
        plotOutput(ns("barchart"))
} 

plot_barchart = function(input, output, session, dat) {
        # Plots a bar chart of an user-selected variable.
        #
        # dat: a reactive expression when called will return a data frame. Must
        #       call it using dat(). The returned data frame must contain a variable 
        #       named "count" and the variable name returned by xvar().
        output$barchart = renderPlot({
                plt_barchart(dat()) # plt_barchart is defined in R/helper
        })
}

