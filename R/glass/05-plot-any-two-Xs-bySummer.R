## BEGIN visualize the distributions of two x vars ##

# make function to plot scatter plot
plt = mk_scatterplot(Glass)

x1=xvars[1] #choose the the variable on x-axis
x2=xvars[2] #choose the the variable on y-axis

title = paste(x1, "vs", x2)
p = plt(xvar=x1, yvar=x2, xlab=paste(x1), ylab=paste(x2), main=title,
        pt_size=1.2, pt_alpha=0.5, add_line=T)
print(p)


## END visualize the distributions of two x vars ##