mk_tbl_freq_pct = function(dat, varname) {
        # Returns a data frame of 3 columns: category, count, and percent.
        #
        # dat: a data frame 
        # varname: string, name of a variable on dat

        # calc freq        
        tbl = table(dat[[varname]])
        
        # calc pct
        pct = prop.table(tbl)
        
        # rename
        tbl = data.frame(tbl); names(tbl)[2] = "count"
        pct = data.frame(pct); names(pct)[2] = "percent"
        
        # merge
        out = merge(tbl, pct) %>% arrange(desc(count))
        
        # format decimals into %
        out$percent = format_as_pct(out$percent)

        # update var name        
        names(out)[1] = varname
        
        # order the categories in descending order of the counts
        # this will order the bars from tallest to shortest from left to right
        out[[varname]] = reorder(out[[varname]], -out$count)
        
        # return
        out
}