seperate_vars = function(dat) {
        # Separates the variables in dat into continuous and categorical groups.
        # Returns a list of 2 vectors of continuous variable names and categorical
        #       variable names respectively.
        #
        # dat: a data frame 
        
        # extract variable names and types
        var_types = sapply(dat, class)
        varnames  = names(var_types)
        
        # separate into integer, continuous and categorical 
        vars_int  = varnames[var_types == "integer"]
        vars_con  = varnames[var_types == "numeric"]
        vars_cat  = varnames[var_types %in% c("character", "factor")]
        
        # re-classify integer vars as continuous or categorical
        for (varname in vars_int) {
                if (length(unique(dat[[varname]])) > 10) 
                        vars_con = c(vars_con, varname)
                else vars_cat = c(vars_cat, varname)
        }
        
        # return
        list(con=vars_con, cat=vars_cat)
}