# helper functions for R

list_packages <- function(){
   ip <- as.data.frame(installed.packages()[,c(1,3:4)])
   rownames(ip) <- NULL
   ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
   return(ip)
}

