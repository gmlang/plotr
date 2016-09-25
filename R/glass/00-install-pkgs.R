# install packages
cran_pkgs = c("devtools", "tidyr", "dplyr", "mlbench")
for (pkg in cran_pkgs) {
        if (!pkg %in% installed.packages()) {
                cat(paste(pkg, "missing, will attempt to install\n"))
                install.packages(pkg)
        } else cat(paste(pkg, "installed OK\n"))
}

github_pkgs = c("scales", "ggplot2", "ggthemes", "ezplot")
for (pkg in github_pkgs) {
        if (!pkg %in% installed.packages()) {
                cat(paste(pkg, "missing, will attempt to install\n"))
                if (pkg %in% c("scales", "ggplot2"))
                        devtools::install_github(paste0("hadley/", pkg))
                if (pkg == "ggthemes")
                        devtools::install_github(paste0("jrnold/", pkg))
                if (pkg == "ezplot")
                        devtools::install_github(paste0("gmlang/", pkg))
        } else cat(paste(pkg, "installed OK\n"))
}

cat("### All required packages installed ###")


