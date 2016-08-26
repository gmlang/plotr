# change max upload file size to 30 MB, default is 5 MB
options(shiny.maxRequestSize = 30*1024^2, shiny.reactlog = T)

library(shiny)
library(dplyr)
library(tidyr)

server = function(input, output) {
        # implement data uploading
        datafile = callModule(upload, "datafile") # returns a reactive expression
        
        ## BEGIN display info about the uploaded data ##
        
        # display the structure of the uploaded data
        output$datastruct = renderPrint({
                str(datafile()) # call the reactive with () at the end
        })
        
        # display the 1st 100 rows
        output$first100rows = renderDataTable({
                show_nrows = 100
                dat = datafile()
                if (nrow(dat) > show_nrows) dat[1:show_nrows, ]
                else dat
        })
        
        ## END display info about the uploaded data ##
        
        
        
        # seperate the vars into continuous vs categorical ones
        varnames = reactive({
                seperate_vars(datafile())
        })
        
        
        
        ## BEGIN Univariate Analysis: Continuous Variable  ##
        
        # implement single variable selection
        pick_var_con = callModule(choose_var, "varname_con",
                                  dat=datafile()[varnames()$con])

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
        
        
        
        
        ## BEGIN Univariate Analysis: Categorical Variable  ##
        
        # implement single variable selection
        pick_var_cat = callModule(choose_var, "varname_cat",
                                  dat=datafile()[varnames()$cat])

        # implement bar chart
        callModule(plot_barchart, "barchart", dat = tbl_freq_pct, 
                   varname = pick_var_cat)
        
        # implement frequency and pct table 
        tbl_freq_pct = reactive({
                mk_tbl_freq_pct(dat=datafile(), varname=pick_var_cat())
        })
                
        # display it
        output$tbl_freq_pct = renderPrint({
                tbl_freq_pct()
        })
        
        ## END Univariate Analysis: Categorical Variable  ##
        
}

shinyServer(server)