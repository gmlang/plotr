scale_axis_helper = function(lstr, axis, rstr) {
        # Helper function used by scale_axis(). Not for external use.
        # It takes in R code strings, combines them and returns an expression 
        # to be evaluated by scale_axis().
        #
        # lstr: string, the left side of ggplot2 code.
        # axis: string, of value "x" or "y".
        # rstr: string, the right side of ggplot2 code.
        
        out_str = paste0(lstr, axis, rstr)
        parse(text = out_str)
}

scale_axis = function(p, axis="y", scale=NULL, pct_max=1, pct_jump=0.2) {
        # Takes a ggplot2 object as input and applies to its x-axis or y-axis 
        # one of the following scales: 
        #       comma: display big numbers in 000,000 format
        #       log  : use log scale
        #       log1p: use log(x+1) scale
        #       log10: use log10 scale
        #       pct  : use % format, the values must be between 0 and 1
        # Returns a ggplot2 object with the new scale applied to the input axis.      
        #
        # p: ggplot2 object.
        # axis: string, of value "x" or "y". Default = "y". 
        # scale: string, of value "comma", "log", "log1p", "log10", or "pct". 
        #        Default = NULL, which uses the original scale.
        # pct_max: number, <= 1. It specifies the max value when using percent 
        #       format. Default = 1.
        # pct_jump: number, between 0 and 1. It specifies the interval width 
        #       between ticks when using percent format. Default = 0.2.
        
        x = deparse(substitute(p))
        l = paste(x, "=", x, "+ ggplot2::scale_")
        r_comma = "_continuous(labels = scales::comma)"
        r_log = "_continuous(trans = scales::log_trans(),
        breaks = scales::trans_breaks('log', function(x) exp(x)),
        labels = scales::trans_format('log', scales::math_format('e'^.x)))"
        r_log1p = "_continuous(trans = scales::log1p_trans(),
        breaks = scales::trans_breaks('log1p', function(x) exp(x)-1),
        labels = scales::trans_format('log1p', scales::math_format('e'^.x-1)))"
        r_log10 = "_log10(breaks = scales::trans_breaks('log10', function(x) 10^x),
        labels = scales::trans_format('log10', scales::math_format(10^.x)))"
        r_pct = paste0("_continuous(labels = scales::percent, limits = c(0, ",
                       pct_max, "), breaks = seq(0,", pct_max, ",", pct_jump, "))")        
        
        pexpr = NULL # need this for it to work when using knitr       
        pexpr = switch(scale,
                       comma = scale_axis_helper(l, axis, r_comma),
                       log = scale_axis_helper(l, axis, r_log),
                       log1p = scale_axis_helper(l, axis, r_log1p),
                       log10 = scale_axis_helper(l, axis, r_log10),
                       pct = scale_axis_helper(l, axis, r_pct))
        p = eval(pexpr)
        p
}
