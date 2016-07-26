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
                
                #plot button
                randomVals <- eventReactive(input$getPlot, {
                        input$var
                })
                
                output$plot <- renderPlot({
                        dummy=filedata()
                        sv = randomVals()
                        xv = as.data.frame(dummy[,c(sv)])
                        #Plots
                        if (input$plot_type == "Histogram"){
                                ggplot(filedata(), aes(x = xv)) + 
                                geom_histogram(binwidth = 0.3)+
                                geom_vline(aes(xintercept=colMeans(xv, na.r=T)), 
                                          color="red", linetype="dashed", size=1)+
                                xlab(input$var)
                        }else if(input$plot_type == "QQ plot"){
                                ggplot(filedata(), aes(sample = xv)) + stat_qq()+
                                geom_abline(intercept = 0, slope = 1,
                                            color = "red", linetype = "dashed", 
                                            size = 1)+
                                ylab(input$var)
                        }else if(input$plot_type == "Barplot of frequencies"){
                                ggplot(filedata(), aes(x = xv)) + 
                                geom_bar(aes(y = (..count..)/sum(..count..)))+
                                xlab(input$var)+
                                ylab("frequency")
                        }
                })
                
                
})
