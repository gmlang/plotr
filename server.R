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
