## BEGIN Multivariate Analysis: Continuous vs. Categorical Variables ##

# implement variable selection
pick_cat_xvar2 = callModule(choose_var, "cat_xvar2", head = "Select x variable", 
                            vars = varnames_cat, init_var_idx = 1)
pick_cat_yvar2 = callModule(choose_var, "cat_yvar2", head = "Select y variable",
                            vars = varnames_cat, init_var_idx = 2)

# implement boxplot
callModule(plot_mosaic, "mosaic", dat=datafile, xvar=pick_cat_xvar2, 
           yvar=pick_cat_yvar2)


        
## BEGIN Multivariate Analysis: Continuous vs. Categorical Variables ##
