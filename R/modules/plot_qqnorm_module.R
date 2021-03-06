plot_qqnorm_ui = function(id) {
        ns = NS(id)
        plotOutput(ns("qqnorm"), height="600", width="600")
}

plot_qqnorm = function(input, output, session, dat, varname, trans_x) {
        # Plots a QQ-normal plot of an user-selected variable
        #
        # dat: a reactive expression when called will return a data frame that
        #       contains the variable selected by user.
        # varname: a reactive expression when called will return the name of
        #       the variable selected by user. Need to use varname() to call it.
        # trans_x: a reactive expression when called will return the name of 
        #       the variable transformation selected by user. Need to use 
        #       trans_x() to call it.
        output$qqnorm = renderPlot({
                if (req(varname() %in% names(dat())))
                        web_display(
                                switch(trans_x(),
                                       none = plt_qqnorm(dat()[[varname()]]), 
                                       log = plt_qqnorm(log(dat()[[varname()]])),
                                       log1p = plt_qqnorm(log(dat()[[varname()]]+1)),
                                       log10 = plt_qqnorm(log10(dat()[[varname()]]))
                               )) # plt_qqnorm is defined in R/helper
        })
}

