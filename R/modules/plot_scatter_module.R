plot_scatter_ui = function(id) {
        ns = NS(id)
        plotOutput(ns("scatterplot"), height="600", width="600")
}

plot_scatter = function(input, output, session, dat, 
                        xvar, yvar, fillby, trans_x, trans_y) {
        # Plots a scatter plot of user-selected variables.
        #
        # dat: a reactive expression when called will return a data frame that
        #       contains the variable selected by user. Use dat() to call it.
        # xvar: a reactive expression when called will return the name of
        #       the x variable selected by user. Use xvar() to call it.
        # yvar: a reactive expression when called will return the name of
        #       the y variable selected by user. Use yvar() to call it.
        # fillby: a reactive expression when called will return the name of
        #       the fillby variable selected by user. Use fillby() to call it.
        # trans_x: a reactive expression when called will return the name of 
        #       the xvar transformation selected by user. Use trans_x() to call it.
        # trans_y: a reactive expression when called will return the name of 
        #       the yvar transformation selected by user. Use trans_y() to call it.
        output$scatterplot = renderPlot({
                # plt_scatter is defined in R/helper
                web_display(plt_scatter(dat(), xvar(), yvar(), fillby(), 
                                        trans_x(), trans_y()))
        })
        
}