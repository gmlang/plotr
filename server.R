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
                        selectizeInput("xvar", "Explanatory Variables:",items, selected = NULL)
                
                })
                
                output$colflag <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        checkboxInput("colflag", "Color by", FALSE)
                })
                #output color
                output$color <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        #Let's only show numeric columns
                        nums <- sapply(df, is.factor)
                        items=names(nums[nums])
                        names(items)=items
                        if(input$plot_type == "Scatterplot"){
                                selectInput("category", "Category Variable:",items)
                        }
                        
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
                
                output$xscale <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("xscale", "Change X scale",
                                     c("comma", "log", "log10",
                                       "log2","percentage"), 
                                     selected = NULL)
                })
                
                output$yscale <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("yscale", "Change Y scale",
                                     c("comma", "log", "log10",
                                       "log2","percentage"), 
                                     selected = NULL)
                })
                
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
                                p = ezplot::scale_axis(p, "x", scale=input$xscale)
                                
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
                                p = scale_axis(p, scale=input$yscale)
                                p = ezplot::scale_axis(p, "x", scale=input$xscale)
                                
                        }else if(input$plot_type == "Scatterplot"){
                                p <- ggplot(filedata(), aes_string(x=input$xvar, y=input$yvar)) + geom_point()
                                
                                if (input$colflag==TRUE){
                                        p <- p + aes_string(color=input$category)
                                }
                                p <- p + geom_point(size = 3)
                                p = scale_axis(p, scale = input$yscale)
                                p = ezplot::scale_axis(p, "x", scale=input$xscale)
                                print(p)
                                
                        }else if(input$plot_type == "Boxplot"){
                                plt = mk_boxplot(filedata())
                                title = paste('Distribution of',input$yvar)
                                p = plt(input$xvar, input$yvar, xlab=input$xvar,ylab=input$yvar,
                                        main=title, lab_at_top = F,vpos = -0.5, legend=F)
                                p = scale_axis(p, scale = input$yscale)
                                p = ezplot::scale_axis(p, "x", scale=input$xscale)
                                print(p)
                                
                        }else if (input$plot_type == "Mosaic Plot"){
                                #Mosaic
                                }
                        
                }
                
                
})
