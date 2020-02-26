library(readr)
library(tidyr)
library(dplyr)

filename <- "..."

dat <- read.csv2(filename)

can.be.date <- function(x, ...){
  
  tryCatch(
    return(inherits(as.Date(x), 'Date')),
    error = function(e){
      return(FALSE)
    }
  )
  
}

apply(dat["Lista.transakcji"], 1, can.be.date)

