library(shiny)
library(ggplot2)

shinyServer(
        function(input, output) {
                
                filedata <- reactive({
                        infile <- input$datafile
                        if (is.null(infile)) {
                                # User has not uploaded a file yet
                                return(NULL)
                        }
                        read.csv(infile$datapath)
                })
                
                output$x <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        items=names(df)
                        names(items)=items
                        selectInput("var", "Variable:",items)
                        
                })
                
                
                output$plot <- renderPlot({
                        ggplot(filedata(), aes(x = EngDispl)) + 
                        geom_histogram() 
                })
                
})
