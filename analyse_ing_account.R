library(readr)
library(tidyr)
library(dplyr)

filename <- "..."


dat <- read.csv2(filename, stringsAsFactors = FALSE)

can.be.date <- function(x, ...){
  tryCatch(
    return(inherits(as.Date(x), 'Date')),
    error = function(e){
      return(FALSE)
    }
  )
}

dat <- dat[apply(dat["Lista.transakcji"], 1, can.be.date), c(1, 3, 4, 7, 9, 10) ]
colnames(dat) <- c("date", "receiver", "title", "details", "amount", "currency")

dat <- mutate(dat, 
              date = parse_date(date),
              amount = parse_number(amount)/100) 

dat <- filter(dat, !is.na(amount))

dat %>%
  mutate(year = strftime(date, "%Y"),
         month = strftime(date, "%m")) %>%
  group_by(year, month) %>%
  summarise(pln_in = sum(amount[amount > 0]),
            pln_out = sum(amount[amount < 0]),
            balance = pln_in + pln_out)
  
