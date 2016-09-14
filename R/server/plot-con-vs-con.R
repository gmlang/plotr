## BEGIN Multivariate Analysis: Continuous vs. Continuous Variables ##

# implement single variable selection
pick_con_xvar = callModule(choose_var, "con_xvar", head = "Select x variable", 
                           vars = varnames_con)
pick_con_yvar = callModule(choose_var, "con_yvar", head = "Select y variable", 
                           vars = varnames_con)

# implement variable transformation selection
pick_trans_xvar = callModule(choose_transformation, "trans_xvar",
                             head = "Select a transformation for x")
pick_trans_yvar = callModule(choose_transformation, "trans_yvar",
                             head = "Select a transformation for y")

# # implement histogram
# callModule(plot_hist, "histogram", dat=datafile, 
#            xvar=pick_var_con, trans_x=pick_trans)
# 
# 
# # implement summary stats 
# output$summary = renderPrint({
#         if (req(pick_var_con() %in% names(datafile()))) {
#                 x = datafile()[[pick_var_con()]]
#                 if (pick_trans() == "none") return(summary(x))
#                 if (pick_trans() == "log") return(summary(log(x)))
#                 if (pick_trans() == "log1p") return(summary(log(x+1)))
#                 if (pick_trans() == "log10") return(summary(log10(x)))
#         }
# })
# 
# # implement qqplot
# callModule(plot_qqnorm, "qqplot", dat=datafile, 
#            varname=pick_var_con, trans_x=pick_trans)

        
## BEGIN Multivariate Analysis: Continuous vs. Continuous Variables ##
