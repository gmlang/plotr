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
                
                output$plot_type <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("plot_type", "Plot Type",
                                     c("Histogram", "QQ plot", "Barplot"), 
                                     selected = NULL)
                })
                
                output$plot_type2 <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("plot_type2", "Plot Type",
                                     c("Scatterplot", "Boxplot", "Mosaic plot"), 
                                     selected = NULL)
                })
                
                output$var <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        if(input$plot_type == "Histogram" || input$plot_type == "QQ plot"){
                                nums <- sapply(df, is.numeric)
                                items=names(nums[nums])
                                names(items)=items
                                selectInput("var", "Variable:",items)
                        }else if(input$plot_type == "Barplot"){
                                nums <- sapply(df, is.factor)
                                items=names(nums[nums])
                                names(items)=items
                                selectInput("var", "Variable:",items)
                        }
                        
                })
                
                #output yvar
                output$yvar <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        if(input$plot_type2 == "Scatterplot" || input$plot_type2 =="Boxplot"){
                                nums <- sapply(df, is.numeric)
                                items=names(nums[nums])
                                names(items)=items
                                selectInput("yvar", "Response Variable:",items)
                        }else if(input$plot_type2 == "Mosaic plot"){
                                nums <- sapply(df, is.factor)
                                items=names(nums[nums])
                                names(items)=items
                                selectInput("yvar", "Response Variable:",items)
                        }
                        
                })
                
                #output xvars
                output$xvar <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        
                        if(input$plot_type2 == "Scatterplot"){
                                nums <- sapply(df, is.numeric)
                                items=names(nums[nums])
                                names(items)=items
                                selectInput("xvar", "Explanatory Variables:",items)
                        }else if(input$plot_type2 == "Mosaic plot" || input$plot_type2 =="Boxplot"){
                                nums <- sapply(df, is.factor)
                                items=names(nums[nums])
                                names(items)=items
                                selectInput("xvar", "Explanatory Variables:",items)
                        }
                })
                
                output$colflag <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        if(input$plot_type2 == "Scatterplot"){
                                checkboxInput("colflag", "Color by", FALSE)
                        }
                })
                #output color
                output$color <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        #Let's only show numeric columns
                        nums <- sapply(df, is.factor)
                        items=names(nums[nums])
                        names(items)=items
                        if(input$plot_type2 == "Scatterplot"){
                                selectInput("category", "Category Variable:",items)
                        }
                })
                
              
                
                
                output$one_variable <- renderPlot({
                        print(plotInput1())
                })
                
                output$multi_variable <- renderPlot({
                        print(plotInput2())
                })
                
                plotInput1 <- function(){
                        #Plots
                        if (input$plot_type == "Histogram"){
                                plt = mk_distplot(filedata())
                                title = paste('Number of',input$var )
                                p = plt(input$var, binw=0.3, xlab=input$var, main=title,
                                        add_vline_mean=T, add_vline_median=T)
                                
                        }else if(input$plot_type == "QQ plot"){
                                
                                
                        }else if(input$plot_type == "Barplot"){
                                data(filedata())
                                str(filedata())
                                f = tally1way(filedata())
                                df = f(input$var)
                                df
                                title = paste('Frequencies of Each', input$var)
                                plt = mk_barplot(df)
                                p = plt(input$var,'pct', fillby=input$var,
                                        xlab = input$var, main=title, legend=F)
         
                        }
                        
                }
                
                plotInput2 <- function(){
                        if (input$plot_type2 == "Boxplot"){
                                plt = mk_boxplot(filedata())
                                title = paste('Distribution of',input$yvar)
                                p = plt(input$xvar, input$yvar, xlab=input$xvar,ylab=input$yvar,
                                        main=title, lab_at_top = F,vpos = -0.5, legend=F)
                                
                        }else if(input$plot_type2 == "Scatterplot"){
                                p <- ggplot(filedata(), aes_string(x=input$xvar, y=input$yvar)) + geom_point()
                                
                                if (input$colflag==TRUE){
                                        p <- p + aes_string(color=input$category)
                                }
                                p <- p + geom_point(size = 3)
                                
                        }else if (input$plot_type2 == "Mosaic plot"){
                                #Mosaic
                        }
                }
                
                
})
