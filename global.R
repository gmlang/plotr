# set paths
modules_path = "R/modules"
helper_path  = "R/helper"

# load modules and helpers
for (fname in list.files(modules_path)) source(file.path(modules_path, fname))
for (fname in list.files(helper_path)) source(file.path(helper_path, fname))
