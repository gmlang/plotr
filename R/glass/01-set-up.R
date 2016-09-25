library(mlbench)
library(ezplot)

# load data
data(Glass)
str(Glass)

# separate vars
yvar = "Type"
xvars = names(Glass)[names(Glass) != yvar]

