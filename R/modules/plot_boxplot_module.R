plot_boxplot_ui = function(id) {
        ns = NS(id)
        plotOutput(ns("boxplot"), height="600", width="600")
}

plot_boxplot = function(input, output, session, dat, xvar, yvar, trans_y) {
        # Plots a boxplot of user-selected variables.
        #
        # dat: a reactive expression when called will return a data frame that
        #       contains the variable selected by user. Use dat() to call it.
        # xvar: a reactive expression when called will return the name of
        #       the x variable selected by user. Use xvar() to call it.
        # yvar: a reactive expression when called will return the name of
        #       the y variable selected by user. Use yvar() to call it.
        # trans_y: a reactive expression when called will return the name of 
        #       the yvar transformation selected by user. Use trans_y() to call it.
        output$boxplot = renderPlot({
                # plt_boxplot is defined in R/helper
                web_display(plt_boxplot(dat(), xvar(), yvar(), trans_y()))
        })
        
}