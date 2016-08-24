# change max upload file size to 30 MB, default is 5 MB
options(shiny.maxRequestSize = 30*1024^2, shiny.reactlog = T)

server = function(input, output) {
        # implement data uploading
        datafile = callModule(upload, "datafile") # returns a reactive expression
        
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
        
        # implement single variable selection
        pick_var = callModule(choose_var, "varname", dat = datafile())
        
        # display the summary of the selected var
        output$summary = renderPrint({
                print(summary(pick_var()$vec))
        })
        
        # implement histogram
        draw_hist = callModule(plot_hist, "bin_num", x = pick_var)
        # note: pass in pick_var without ()
        
        # display histogram
        output$hist = renderPlot({
                draw_hist()
        })
}

shinyServer(server)