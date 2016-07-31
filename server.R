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
                
                #download
                output$getPlot <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        downloadButton('download', 'Download Plot')
                })
                
                #select plot type
                output$plot_type <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("plot_type", "Plot Type",
                                     c("Histogram", "QQ plot", "Barplot of frequencies"), 
                                     selected = NULL)
                })
                
                output$download <- downloadHandler(
                        filename = function() { paste(input$dataset, '.png', sep='') },
                        content = function(file) {
                                ggsave(file, plot = output$plot, device = "png")
                        }
                )
                output$download <- downloadHandler(
                        filename =  function() {
                                paste(input$plot_type,".png")
                        },
                        content = function(file){
                                ggsave(file, plot = plotInput(), device = "png")
                                
                        } 
                )
                
                output$plot <- renderPlot({
                        print(plotInput())
                })
                
                plotInput <- function(){
                        #Plots
                        if (input$plot_type == "Histogram"){
                                #ggplot(filedata(), aes(x = xvar)) + 
                                #geom_histogram(binwidth = 0.3)+
                                #geom_vline(aes(xintercept=colMeans(xvar, na.r=T)), 
                                 #         color="red", linetype="dashed", size=1)+
                                #xlab(input$var)
                                plt = mk_distplot(filedata())
                                title = paste('Number of',input$var )
                                p = plt(input$var, binw=0.3, xlab=input$var, main=title,
                                        add_vline_mean=T, add_vline_median=T)
                                
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
                                
                        }
                }
                
                
})
