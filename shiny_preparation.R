packages <- c("rmarkdown", "shinycustomloader", "shinyhelper", "shinyjs", "gridExtra")
install.packages(setdiff(packages, rownames(installed.packages()))) 
