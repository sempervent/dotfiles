packages <- c('plyr','ggplot2','xlsx','reshape2','gridExtra','devtools',
              'curl','phyloseq','RColorBrewer','stringr','biom')
biocon <- c('qiimer','Biobase','BiocGenerics','BiocInstaller','biomformat')

# ipak function to install and load multiple R packages
# from https://gist.github.com/stevenworthington/3178163
ipak <- function(pkg){
   new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
   if (length(new.pkg))
      install.packages(new.pkg, dependencies=TRUE)
   sapply(pkg, require, character.only=TRUE)
}

ipak(packages)

source("https://bioconductor.org/biocLite.R")
biocLite()
biocLite(biocon)
