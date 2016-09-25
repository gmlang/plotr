## BEGIN Univariate Analysis: Continuous Variable  ##

# implement single variable selection
pick_var_con = callModule(choose_var, "varname_con", vars=varnames_con)

# implement variable transformation selection
pick_trans = callModule(choose_transformation, "var_trans")

# implement histogram
callModule(plot_hist, "histogram", dat=datafile, 
           xvar=pick_var_con, trans_x=pick_trans)


# implement summary stats 
output$summary = renderPrint({
        if (req(pick_var_con() %in% names(datafile()))) {
                x = datafile()[[pick_var_con()]]
                if (pick_trans() == "none") return(summary(x))
                if (pick_trans() == "log") return(summary(log(x)))
                if (pick_trans() == "log1p") return(summary(log(x+1)))
                if (pick_trans() == "log10") return(summary(log10(x)))
        }
})

# implement qqplot
callModule(plot_qqnorm, "qqplot", dat=datafile, 
           varname=pick_var_con, trans_x=pick_trans)

        
## END Univariate Analysis: Continuous Variable  ##
