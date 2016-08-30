## BEGIN Univariate Analysis: Categorical Variable  ##

# implement single variable selection
pick_var_cat = callModule(choose_var, "varname_cat", varnames()$cat)

# implement frequency and pct table 
tbl_freq_pct = reactive({
        mk_tbl_freq_pct(dat=datafile(), varname=pick_var_cat())
})

# implement bar chart
callModule(plot_barchart, "barchart", dat = tbl_freq_pct, xvar = pick_var_cat)

# display it
output$tbl_freq_pct = renderPrint({
        tbl_freq_pct()
})

## END Univariate Analysis: Categorical Variable  ##
