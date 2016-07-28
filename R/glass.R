library(mlbench)
library(ezplot)

# load data
data(Glass)
str(Glass)

# separate vars
yvar = "Type"
xvars = names(Glass)[names(Glass) != yvar]
        

## BEGIN visualize the distribution of each x var ##

# make function to plot histogram
plt = mk_distplot(Glass)

x = "RI"
title = paste("Distribution of", x)
p = plt(x, binw=0.002, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: slightly right skewed

x = "Na"
title = paste("Distribution of", x)
p = plt(x, binw=0.2, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: outliers at both ends

x = "Mg"
title = paste("Distribution of", x)
p = plt(x, binw=0.2, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: concentration at 0 and the rest data are left skewed

x = "Al"
title = paste("Distribution of", x)
p = plt(x, binw=0.2, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: slightly right skewed, possible outliers

x = "Si"
title = paste("Distribution of", x)
p = plt(x, binw=0.2, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: outliers at both ends

x = "K"
title = paste("Distribution of", x)
p = plt(x, binw=0.2, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: extremely right skewed, outliers at the right end.

x = "Ca"
title = paste("Distribution of", x)
p = plt(x, binw=0.3, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: long tails to both left and right, possible outliers, slightly right skewed

x = "Ba"
title = paste("Distribution of", x)
p = plt(x, binw=0.2, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: extremely right skewed

x = "Fe"
title = paste("Distribution of", x)
p = plt(x, binw=0.03, xlab=x, main=title, add_vline_mean=T) 
print(p)
# remark: extremely right skewed

## BEGIN visualize the distribution of each x var ##

