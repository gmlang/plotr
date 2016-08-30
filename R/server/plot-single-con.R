## BEGIN Univariate Analysis: Continuous Variable  ##

# implement single variable selection
pick_var_con = callModule(choose_var, "varname_con", varnames()$con)

# implement variable transformation selection
pick_trans = callModule(choose_transformation, "var_trans")

# implement histogram
callModule(plot_hist, "histogram", dat=datafile()[varnames()$con], 
           varname=pick_var_con, trans_x=pick_trans)
# note: pass in pick_var without () because varname is defined to take 
#       a reactive expression instead of the value it returns

# implement summary stats 
output$summary = renderPrint({
        x = datafile()[[pick_var_con()]]
        if (pick_trans() == "none") return(summary(x))
        if (pick_trans() == "log") return(summary(log(x)))
        if (pick_trans() == "log1p") return(summary(log(x+1)))
        if (pick_trans() == "log10") return(summary(log10(x)))
})

## END Univariate Analysis: Continuous Variable  ##
