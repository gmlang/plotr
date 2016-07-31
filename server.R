library(shiny)
library(ezplot)
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
                
                #output yvar
                output$yvar <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        items=names(df)
                        names(items)=items
                        selectInput("yvar", "Response Variable:",items)
                        
                })
                
                #output xvars
                output$xvar <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        items=names(df)
                        names(items)=items
                        selectizeInput("xvar", "Explanatory Variables:",items,multiple = TRUE)
                        
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
                                     c("Histogram", "QQ plot", "Barplot of frequencies",
                                       "Scatterplot","Boxplot","Mosaic Plot"), 
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
                                plt = mk_distplot(filedata())
                                title = paste('Number of',input$xvar )
                                p = plt(input$xvar, binw=0.3, xlab=input$xvar, main=title,
                                        add_vline_mean=T, add_vline_median=T)
                                
                        }else if(input$plot_type == "QQ plot"){
                                #ggplot(filedata(), aes(sample = xvar)) + stat_qq()+
                                #geom_abline(intercept = 0, slope = 1,
                                            #color = "red", linetype = "dashed", 
                                            #size = 1)+
                                #ylab(input$xvar)
                        }else if(input$plot_type == "Barplot of frequencies"){
                                data(filedata())
                                str(filedata())
                                f = tally1way(filedata())
                                df = f(input$xvar)
                                df
                                title = paste('Frequencies of Each', input$xvar)
                                plt = mk_barplot(df)
                                p = plt(input$xvar,'pct', fillby=input$xvar,
                                        xlab = input$xvar, main=title, legend=F)
                                p = scale_axis(p, scale="comma")
                        }else if(input$plot_type == "Scatterplot"){
                                plt = mk_scatterplot(filedata())
                                purple = cb_color("reddish_purple")
                                green = cb_color("bluish_green")
                                title = paste(input$yvar,'vs', input$xvar)
                                p = plt(xvar=input$xvar, yvar=input$yvar, xlab=input$xvar,
                                        ylab=input$yvar, main=title,
                                        pt_size=1.2, pt_alpha=0.5, add_line=T) # use log10 scale on both axes
                                p = scale_axis(p, scale="log10") # default is y-axis p = scale_axis(p, axis="x", scale="log10")
                                p = p + ggplot2::scale_color_manual(values = c(purple, green))
                                # display plot
                                print(p)
                        }
                }
                
                
})
