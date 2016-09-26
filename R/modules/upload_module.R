# browsers won't allow user to upload .rds file 
# therefore, only implement .csv or .txt upload

upload_ui = function(id) {
        ns = NS(id)
        tagList(
                fileInput(ns("file"), "Select a CSV or TXT file",
                          accept=c('text/comma-separated-values,text/plain',
                                   'text/csv', '.csv', '.txt')),
                radioButtons(ns("sep"), "Delimiter", 
                             choices = c(Comma=',', Semicolon=';', Tab='\t'),
                             selected = ','),
                checkboxInput(ns("heading"), "Has header row", value = T),
                textInput(ns("na_string"), "NA symbol", value = "NA")
        )
}

upload = function(input, output, session, ...) {
        # Returns a reactive expression that will return user-uploaded data as a 
        #       data frame when called.
        
        user_file = reactive({
                # if no file is selected, don't do anything
                req(input$file)
        })
        
        # parse user uploaded data into a data frame
        reactive({
                read.table(user_file()$datapath, sep = input$sep,
                           header = input$heading, na.strings = input$na_string,
                           stringsAsFactors = F, ...)
        })
}