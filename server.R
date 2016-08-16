# change max upload file size to 30 MB, default is 5 MB
options(shiny.maxRequestSize=30*1024^2) 

server = function(input, output) {
    datafile = callModule(upload, "datafile")
    
    output$datastruct = renderPrint({ str(datafile()) })
    
    output$first100rows = renderDataTable({
        dat = datafile()
        show_nrows = 100
        if (nrow(dat) > show_nrows) dat[1:show_nrows,] 
        else dat
    })
}


shinyServer(server)
