yahoo <- read.csv('http://download.finance.yahoo.com/d/quotes.csv?f=snl1&s=AAPL,GOOG')

library(Quandl)
Quandl('YAHOO/AAPL')

if (!require(BatchGetSymbols)) install.packages('BatchGetSymbols')

library(BatchGetSymbols)

# set dates
first.date <- Sys.Date() - 60
last.date <- Sys.Date()
freq.data <- 'daily'
# set tickers
tickers <- c('ETH', 'AAPL')

l.out <- BatchGetSymbols(tickers = tickers, 
                         first.date = first.date,
                         last.date = last.date, 
                         freq.data = freq.data,
                         cache.folder = file.path(tempdir(), 
                                                  'BGS_Cache') ) # cache in tempdir()
print(l.out$df.control)

library(tidyverse)
p <- ggplot(l.out$df.tickers, aes(x = ref.date, y = price.close))
p <- p + geom_line()
p <- p + facet_wrap(~ticker, scales = 'free_y') 
print(p)



first.date <- Sys.Date()-365
last.date <- Sys.Date()

df.SP500 <- GetSP500Stocks()
tickers <- df.SP500$Tickers

l.out <- BatchGetSymbols(tickers = tickers,
                         first.date = first.date,
                         last.date = last.date)

print(l.out$df.control)
print(l.out$df.tickers)


mydata <- l.out[["df.tickers"]]

ggplot(data = subset(mydata, mydata$ticker == 'AAPL'), aes(x = ref.date, y = price.close)) + geom_line() + geom_smooth(method = 'gam')


apple <- subset(mydata, mydata$ticker == 'AAPL')
ggplot(apple, aes(x = ref.date, y = price.close)) + geom_line()+
  geom_smooth(aes(x = ref.date, y = volume/1000000), color = 'red')
