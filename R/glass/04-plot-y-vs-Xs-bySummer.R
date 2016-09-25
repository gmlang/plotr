## BEGIN visualize the distribution of each x var vs y##

# make function to plot boxplot
plt = mk_boxplot(Glass)

x = "RI"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "Na"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "Mg"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "Al"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "Si"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "K"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)
#take out the outlier and zoom in the plot
x.upperlimit = 3
plt1 = mk_boxplot(subset(Glass,Glass[,x]<x.upperlimit))
p1 = plt1(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p1)

x = "Ca"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "Ba"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)

x = "Fe"
title = paste("Distribution of", x, "by Types")
p = plt(yvar, x, main=title, ylab=x, xlab="Type", add_label = F)
print(p)


## END visualize the distribution of each x var vs y##