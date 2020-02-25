library(readr)
library(tidyr)

can.be.date <- function(x){
  
  assign("check", TRUE, env = globalenv())
  
  tryCatch(
    as.Date(x),
    error = function(e){
      assign("check", FALSE, env=globalenv())
    },
    finally = {
      return(get("check", env=globalenv()))
    }
  )
}