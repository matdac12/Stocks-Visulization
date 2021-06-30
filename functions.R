library(tidyquant)
library(recipes)
library(tidyverse)
library(plotly)

# create function that gets ticker name and returns graph of company

#get data firsts
get_stock_data <- function(ticker, first_date = '2020-01-01', last_date = Sys.Date()) {
  
  
  get_prices <- tq_get(ticker,
                       get = "stock.prices", 
                       from = first_date, 
                       to = last_date)
  
  return(get_prices)
  
}

#plot selected ticker
plot_stock_data <- function(ticker, first_date = '2020-01-01', last_date = Sys.Date()){
  
  df <- get_stock_data(ticker, first_date, last_date)
  
  p <- ggplot(df, aes(date,close)) + geom_line() + geom_line(aes(date,high), color = 'green', alpha = 0.3,size = 0.3)+
    geom_line(aes(date,low), color = 'red', alpha = 0.3,size = 0.3)+
    geom_smooth(aes(date,close),se=F, size = 0.3) +
    labs(title= paste(ticker, 'Price Action'),
         subtitle = paste(first_date, 'trough', last_date),
         x = NULL,
         y = NULL)
  return(p+ theme_bw())
  
  
  
}


