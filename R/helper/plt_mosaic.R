plt_mosaic = function(dat, xvar, yvar, palette="Blues"){
        # Draw mosaic plot using ggplot2
        # Creates a mosaic plot where the dimensions of the cells of a 
        #       confusion matrix represent their marginal proportions.
        #
        # Credit:
        # modified slightly after docsteveharris' solution:
        #       https://gist.github.com/docsteveharris/4e12c86ac2dd96bfa2dd5cbf13ba3e53
        #
        # dat: data frame
        # xvar, yvar: strings, names of the variables in dat
        # palette: string, name of color brewer palette
        dat[[xvar]] = as.factor(dat[[xvar]])
        dat[[yvar]] = as.factor(dat[[yvar]])
                
        jointTable = prop.table(table(dat[[xvar]], dat[[yvar]]))
        plotData = as.data.frame(jointTable)
        names(plotData)[1:2] = c("xvar", "yvar")
        plotData$marginxvar = prop.table(table(dat[[xvar]]))
        plotData$marginyvar = prop.table(table(dat[[yvar]]))
        plotData$yvarHeight = plotData$Freq / plotData$marginxvar
        plotData$xvarCenter = c(0, cumsum(plotData$marginxvar)[1:length(levels(dat[[xvar]]))-1]) +
                plotData$marginxvar / 2
        
        # Define label positions on LEFT (y-axis)
        ylabData = plotData[plotData$xvar==levels(plotData$xvar)[1],]
        dd = (y=c(0, cumsum(ylabData$yvarHeight)))
        ylabData$ylabCenter = sapply(1:(length(dd)-1), 
                                     function(x) dd[x] + (dd[x+1] - dd[x])/2 )
        
        # Define label positions on the BOTTOM (x-axis)
        xlabData = plotData[plotData$yvar==levels(plotData$yvar)[1],]
        dd = (x=c(0, cumsum(xlabData$marginxvar)))
        xlabData$xlabCenter = sapply(1:(length(dd)-1), 
                                     function(x) dd[x] + (dd[x+1] - dd[x])/2 )
        
        ggplot2::ggplot(plotData, ggplot2::aes(xvarCenter, yvarHeight)) +
                ggplot2::geom_bar(stat = "identity", col = "White",
                                  ggplot2::aes(width = marginxvar, fill = yvar)) +
                ggplot2::scale_fill_brewer(type="seq", palette=palette, guide=FALSE) +
                # xlabels
                ggplot2::geom_text(data=xlabData, vjust="inward",
                                   ggplot2::aes(label = as.character(xvar), 
                                                x = xlabCenter, y = -0.05)) +
                # ylabels
                ggplot2::geom_text(data=ylabData, vjust="top", angle=90,
                                   ggplot2::aes(label = as.character(yvar), 
                                                y = ylabCenter, x = -0.05)) +
                ggplot2::xlab("") + ggplot2::scale_x_discrete(labels=NULL) +
                ggplot2::ylab("") + ggplot2::scale_y_discrete(labels=NULL) +
                ggplot2::theme_minimal() +
                ggplot2::theme(plot.margin=ggplot2::margin(rep(20,4)))

}

