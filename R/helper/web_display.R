web_display = function(p, axis_text_size=16, axis_title_size=ggplot2::rel(2),
                       axis_title_vjust_y=1, legend_pos="right", legend_title=T,
                       mar_top=1, mar_right=1, mar_left=1, mar_bottom=1) {
        p = p + ggplot2::theme(
                axis.text.x = ggplot2::element_text(size=axis_text_size),
                axis.text.y = ggplot2::element_text(size=axis_text_size),
                axis.title.x = ggplot2::element_text(size=axis_title_size,
                                                     vjust=-axis_title_vjust_y),
                axis.title.y = ggplot2::element_text(size=axis_title_size,
                                                     vjust=axis_title_vjust_y),
                
                plot.title = ggplot2::element_text(size=axis_title_size),
                
                legend.text = ggplot2::element_text(size=axis_text_size),
                legend.title = ggplot2::element_text(size=axis_title_size),
                legend.position = legend_pos,
                
                plot.margin = grid::unit(c(mar_top, mar_right, 
                                           mar_left, mar_bottom), "lines")
        )
        
        if (!legend_title)
                p = p + ggplot2::theme(legend.title = ggplot2::element_blank())
        
        p
}

