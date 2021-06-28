library(tidyverse)

ggplot(export_dataframe, aes(Date,variance)) + geom_line() + geom_smooth(color = 'yellow', method = 'lm')

summary(glm(data = export_dataframe, UP ~ Volume, family = binomial))

export_dataframe$volatility = export_dataframe$High - export_dataframe$Low

export_dataframe$index = export_dataframe$volatility / export_dataframe$variance

summary(glm(data = export_dataframe, UP ~ index, family = binomial))

export_dataframe = subset(export_dataframe, variance != 0)
export_dataframe = subset(export_dataframe, Date > '2020-01-01')


ggplot(export_dataframe, aes(Date,Close)) + geom_line() + geom_smooth(color = 'yellow')
