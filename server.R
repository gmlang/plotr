library(shiny)
library(ezplot)

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
                #plot button
                output$getPlot <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        actionButton("getPlot", "Plot the variable")
                })
                #select plot type
                output$plot_type <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("plot_type", "Plot Type",
                                     c("Histogram", "QQ plot", "Barplot of frequencies"), 
                                     selected = NULL)
                })
                
                #plot button
                randomVals <- eventReactive(input$getPlot, {
                        input$var
                })
                
                output$plot <- renderPlot({
                        data(filedata())
                        str(filedata())
                        f = tally1way(filedata())
                        df = f('EngDispl')
                        df
                        #Plots
                        if (input$plot_type == "Histogram"){
                                ggplot(filedata(), aes(x = xvar)) + 
                                geom_histogram(binwidth = 0.3)+
                                geom_vline(aes(xintercept=colMeans(xvar, na.r=T)), 
                                          color="red", linetype="dashed", size=1)+
                                xlab(input$var)
                        }else if(input$plot_type == "QQ plot"){
                                ggplot(filedata(), aes(sample = xvar)) + stat_qq()+
                                geom_abline(intercept = 0, slope = 1,
                                            color = "red", linetype = "dashed", 
                                            size = 1)+
                                ylab(input$var)
                        }else if(input$plot_type == "Barplot of frequencies"){
                                data(filedata())
                                str(filedata())
                                f = tally1way(filedata())
                                df = f(input$var)
                                df
                                title = paste('Frequencies of Each', input$var)
                                plt = mk_barplot(df)
                                p = plt(input$var,'pct', fillby=input$var,xlab = input$var, main=title, legend=F)
                                p = scale_axis(p, scale="comma")
                                print(p)
                        }
                })
                
                
})
