plot_mosaic_ui = function(id) {
        ns = NS(id)
        plotOutput(ns("mosaic"), height="600", width="600")
}

plot_mosaic = function(input, output, session, dat, xvar, yvar) {
        # Plots a mosaic of user-selected variables.
        #
        # dat: a reactive expression when called will return a data frame that
        #       contains the variable selected by user. Use dat() to call it.
        # xvar: a reactive expression when called will return the name of
        #       the x variable selected by user. Use xvar() to call it.
        # yvar: a reactive expression when called will return the name of
        #       the y variable selected by user. Use yvar() to call it.
        output$mosaic = renderPlot({
                # plt_mosaic is defined in R/helper
                plt_mosaic(dat(), xvar(), yvar())
        })
}