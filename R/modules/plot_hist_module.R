plot_hist_ui = function(id) {
        ns = NS(id)
        tagList(
                plotOutput(ns("hist")),
                sliderInput(ns("bins"), "Number of bins", 1, 50, 20)
        )
}

plot_hist = function(input, output, session, dat, xvar, trans_x) {
        # Plots a histogram of an user-selected variable
        #
        # dat: a data frame
        # xvar: a reactive expression when called will return the name of
        #       the variable selected by user. Need to use xvar() to call it.
        # trans_x: a reactive expression when called will return the name of 
        #       the variable transformation selected by user. Need to use 
        #       trans_x() to call it.
        output$hist = renderPlot({
                plt_hist(dat, xvar(), trans_x(), input$bins) # plt_hist defined in R/helper
        })
}

