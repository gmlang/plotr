## BEGIN Univariate Analysis: Categorical Variable  ##

# implement single variable selection
pick_var_cat = callModule(choose_var, "varname_cat", vars=varnames_cat)

# implement frequency and pct table 
tbl_freq_pct = reactive({
        if (req(pick_var_cat() %in% names(datafile())))
                mk_tbl_freq_pct(dat = datafile(), varname = pick_var_cat())
})

# implement bar chart
callModule(plot_barchart, "barchart", dat = tbl_freq_pct)

# display it
output$tbl_freq_pct = renderPrint({
        tbl_freq_pct()
})

## END Univariate Analysis: Categorical Variable  ##
