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
                        dataframe <- read.csv(infile$datapath)
                        return(dataframe)
                        
                })
                
                output$var <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        items=names(df)
                        names(items)=items
                        selectInput("var", "Variable:",items)
                        
                })
                
                
                
                output$plot <- renderPlot({
                        sv = input$var
                        dummy=filedata()
                        x <- as.data.frame(dummy[,c(sv)])
                        if (input$plot_type == "Histogram"){
                                ggplot(filedata(), aes(x)) + 
                                geom_bar() 
                        }
                })
                
                
})
