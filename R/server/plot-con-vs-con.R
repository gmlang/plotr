## BEGIN Multivariate Analysis: Continuous vs. Continuous Variables ##

# implement variable selection
pick_con_xvar = callModule(choose_var, "con_xvar", head = "Select x variable", 
                           vars = varnames_con, init_var_idx = 1)
pick_con_yvar = callModule(choose_var, "con_yvar", head = "Select y variable", 
                           vars = varnames_con, init_var_idx = 2)
get_fillby_var = reactive({ c("None", varnames_cat()) })
pick_cat_var = callModule(choose_var, "fillby_var", head = "Select color-by variable",
                          vars = get_fillby_var)


# implement variable transformation selection
pick_trans_xvar = callModule(choose_transformation, "trans_xvar",
                             head = "Select a transformation for x")
pick_trans_yvar = callModule(choose_transformation, "trans_yvar",
                             head = "Select a transformation for y")

# implement scatter plot
callModule(plot_scatter, "scatterplot", dat=datafile, xvar=pick_con_xvar, 
           yvar=pick_con_yvar, fillby = pick_cat_var, 
           trans_x=pick_trans_xvar, trans_y=pick_trans_yvar)


        
## BEGIN Multivariate Analysis: Continuous vs. Continuous Variables ##
