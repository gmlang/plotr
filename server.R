# change max upload file size to 30 MB, default is 5 MB
options(shiny.maxRequestSize=30*1024^2, shiny.reactlog = TRUE) 

server = function(input, output) {
    datafile = callModule(upload, "datafile") # datafile is a reactive expression, use it as if it's a function, datafile()
    
    output$datastruct = renderPrint({ str(datafile()) })
    
    output$first100rows = renderDataTable({
            show_nrows = 100
            dat = datafile() # calling datafile() returns a data frame
            if (nrow(dat) > show_nrows) dat[1:show_nrows,] 
            else dat
    })
    
    output$plot_type <- renderUI({
            dat = datafile()
            radioButtons("plot_type", "Plot Type",
                         c("Histogram", "QQ plot", "Barplot"), 
                         selected = NULL)
    })
    
}


shinyServer(server)
