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
                
                output$getPlot <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        #Let's only show numeric columns
                        actionButton("getPlot", "Plot the variable")
                })
                
                randomVals <- eventReactive(input$getPlot, {
                        input$var
                })
                
                output$plot <- renderPlot({
                        dummy=filedata()
                        sv = randomVals()
                        x <- as.data.frame(dummy[,c(sv)])
                        if (input$plot_type == "Histogram"){
                                ggplot(filedata(), aes(x)) + 
                                geom_histogram(binwidth = 0.5) 
                        }else if(input$plot_type == "QQ plot"){
                                
                        }else if(input$plot_type == "Barplot of frequency"){
                                
                        }
                })
                
                
})
