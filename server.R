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
                
                output$download <- downloadHandler(
                        filename =  function() {
                                paste('plotR',".pdf")
                        },
                        content = function(file){
                                pdf(file)
                                print(plotInput1())
                                print(plotInput2())
                                dev.off()
                        } 
                )
                
                output$getPlot <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        downloadButton('download', 'Download Plot')
                })
                
                output$getPlot2 <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        downloadButton('download', 'Download Plot')
                })
              
                output$scale <- renderUI({
                        df <-filedata()
                        if (is.null(df)) return(NULL)
                        radioButtons("scale", "Change scale",
                                     c("comma", "log", "log10",
                                       "log2","percentage"), 
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
                                p = ezplot::scale_axis(p, "x", scale=input$scale)
                                
                        }else if(input$plot_type == "QQ plot"){
                                var_length = length(filedata()[,input$var])
                                x_thr = qnorm(1:var_length/(1+var_length))
                                
                                var_mean = mean(filedata()[,input$var], na.rm=T)
                                var_sd = sd(filedata()[,input$var], na.rm=T)
                                var_std = (filedata()[,input$var]-var_mean)/var_sd
                                y_smpl = sort(var_std)
                                temp = as.data.frame(cbind(y_smpl,x_thr))
                          
                                plt = mk_scatterplot(temp)
                                p = plt(xvar=x_thr,
                                       yvar=temp$y_smpl,
                                       xlab="Theoretical quantiles",
                                       ylab="Sample quantiles",
                                       pt_size=1.3)
                                p = p+ggplot2::geom_abline(intercept=0, slope=1,
                                                    color="red", linetype="dashed", 
                                                    size=1)
                                
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
                                p = scale_axis(p, scale = input$yscale)
                                p = ezplot::scale_axis(p, "x", scale=input$xscale)
                                
                        }else if (input$plot_type2 == "Mosaic plot"){
                                #Mosaic
                        }
                }
                
                
})
