## BEGIN visualize the distribution of y var ##

# tally up each level
f = tally1way(Glass)
df = f(yvar)
df

# make function to draw bar charts
plt = mk_barplot(df)

# visualize frequencies
title = "Frequencies of Each Type"
p = plt(yvar, "cnt", fillby=yvar, main=title, legend=F)
p = scale_axis(p, scale="comma")
p

# visualize percentages
title = "Percentage of Each Type"
p = plt(yvar, "pct", fillby=yvar, main=title, legend=F)
p = scale_axis(p, scale="pct", pct_jump=0.25)
p

# make a function to append columns of bar label positions to input data frame
g = add_bar_label_pos(df)

# append bar label positions based on pct
tbl = g(yvar, "pct", vpos=0.03) # if putting labels at the top of the bars, label positions are 0.03 higher than values of pct.
tbl

# append bar label positions based on cnt
g = add_bar_label_pos(tbl) # need to update g by calling tbl
tbl = g(yvar, "cnt", vpos=2)
tbl

# make function to draw bar charts again calling on tbl instead of df
plt = mk_barplot(tbl)

# visualize frequencies, label the bars with cnt
title = "Frequencies of Each Type"
p = plt(yvar, "cnt", fillby=yvar, main=title, legend=F,
        barlab="cnt", barlab_at_top=F, barlab_size=5)
p = scale_axis(p, scale="comma")
p

# visualize percentages
title = "Percentage of Each Type"
p = plt(yvar, "pct", fillby=yvar, main=title, legend=F,
        barlab="pct", barlab_use_pct=T, decimals=2,
        barlab_at_top=F, barlab_size=5)
p = scale_axis(p, scale="pct", pct_jump=0.25)
p

## END visualize the distribution of y var ##



