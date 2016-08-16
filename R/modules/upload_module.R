upload_input = function(id) {
    ns = NS(id)
    tagList(
        ## input file is text format
        fileInput(ns("file"), "Select a CSV, TXT or RDS file",
                  accept=c('text/comma-separated-values,text/plain',
                           'text/csv', '.csv', '.txt', ".rds")),
        p("If using RDS file, ignore configurations below entirely."),
        radioButtons(ns('sep'), 'Delimiter', 
                     choices = c(Comma=',', Semicolon=';', Tab='\t'), 
                     selected = ','),
        checkboxInput(ns("heading"), "Has header row", value = T),
        textInput(ns("na_string"), "NA symbol", value = "NA")
    )
}


upload = function(input, output, session, ...) {
    
    user_file = reactive({
        # if no file is selected, don't do anything
        req(input$file)
    })
    
    # parse user uploaded data into a data frame
    reactive({
        # print(user_file()$name)
        if (grepl(".csv$|.txt$", user_file()$name))
            dat = read.csv(user_file()$datapath, sep=input$sep, 
                           header = input$heading, na.strings = input$na_string, 
                           stringsAsFactors = F, ...)
        if (grepl(".rds$", user_file()$name))        
            dat = readRDS(user_file()$datapath)
        
        dat
    })
}
