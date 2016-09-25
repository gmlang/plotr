library(shiny)
library(dplyr)
library(tidyr)

server = function(input, output) {
        # implement data uploading
        datafile = callModule(upload, "datafile") 
        
        # display info of the uploaded data
        source(file.path(server_path, "show-uploaded-data.R"), local=T)
                
        # seperate vars into continuous vs categorical ones
        varnames = reactive({
                seperate_vars(datafile())
        })

        varnames_con = reactive({
                varnames()$con
        })

        varnames_cat = reactive({
                varnames()$cat
        })

        # plot single variable - continuous
        source(file.path(server_path, "plot-single-con.R"), local=T)

        # plot single variable - categorical
        source(file.path(server_path, "plot-single-cat.R"), local=T)

        # plot 2 variables - continuous vs continuous
        source(file.path(server_path, "plot-con-vs-con.R"), local=T)

        # plot 2 variables - continuous vs categorical
        source(file.path(server_path, "plot-con-vs-cat.R"), local=T)
        
        # plot 2 variables - categorical vs categorical
        source(file.path(server_path, "plot-cat-vs-cat.R"), local=T)
}

shinyServer(server)