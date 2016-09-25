## BEGIN display info of the uploaded data ##

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
