## BEGIN Multivariate Analysis: Continuous vs. Categorical Variables ##

# implement variable selection
pick_cat_xvar = callModule(choose_var, "cat_xvar", head = "Select x variable", 
                           vars = varnames_cat)
pick_con_yvar2 = callModule(choose_var, "con_yvar2", head = "Select y variable",
                           vars = varnames_con)

# implement variable transformation selection
pick_trans_yvar2 = callModule(choose_transformation, "trans_yvar2",
                              head = "Select a transformation for y")

# implement boxplot
callModule(plot_boxplot, "boxplot", dat=datafile, xvar=pick_cat_xvar, 
           yvar=pick_con_yvar2, trans_y=pick_trans_yvar2)


        
## BEGIN Multivariate Analysis: Continuous vs. Categorical Variables ##
