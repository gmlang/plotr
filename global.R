library(shiny)
library(tidyr)
library(dplyr)

# change max upload file size to 30 MB, default is 5 MB
options(shiny.maxRequestSize = 30*1024^2, shiny.reactlog = T)

# set paths
modules_path = "R/modules"
helper_path  = "R/helper"
server_path = "R/server"
ui_path = "R/ui"

# load modules and helpers
for (fname in list.files(modules_path)) source(file.path(modules_path, fname))
for (fname in list.files(helper_path)) source(file.path(helper_path, fname))
