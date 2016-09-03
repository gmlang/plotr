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
        
        # plot single variable - continuous
        source(file.path(server_path, "plot-single-con.R"), local=T)
        
        # plot single variable - categorical
        source(file.path(server_path, "plot-single-cat.R"), local=T)
        
        
}

shinyServer(server)