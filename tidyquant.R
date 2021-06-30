library(tidyquant)
library(recipes)
library(tidyverse)
library(plotly)
library(xlsx)
# set stock and dates
ticker <- 'AAPL'
first_date <- '2019-01-01'
last_date <-  Sys.Date()

# get data with tq_get
df_prices <- tq_get(ticker,
                    get = "stock.prices", 
                    from = first_date, 
                    to = last_date)

glimpse(df_prices)

ggplot(data = df_prices, aes(x=date, y = close)) + geom_line()

#Get all stocks in the exchange

NYSE_tickers = tq_exchange("NYSE") 
NASDAQ_tickers = tq_exchange("NASDAQ") %>%  select(symbol, company)

#get options
print(tq_index_options())

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
  
  p <- ggplot(df, aes(date,close)) + geom_line() +
    labs(title= paste(ticker, 'Price Action'),
         subtitle = paste(first_date, 'trough', last_date),
         x = NULL,
         y = NULL)
  return(ggplotly(p))
  
  
  
}

plot_stock_data('AAPL', '2021-01-01')
