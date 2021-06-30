library(tidyquant)
library(recipes)
library(tidyverse)
library(plotly)
library(shiny)
library(readxl)

source('functions.R')
tickers <- read_excel('NASDAQ_tickers.xlsx')
tickers$full <- paste(tickers$symbol, ' - ', tickers$company) 

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    theme = shinythemes::shinytheme('cosmo'),
    
    tags$style(type="text/css",
               ".shiny-output-error { visibility: hidden; }",
               ".shiny-output-error:before { visibility: hidden; }"
    ),

    # Application title
    titlePanel("STONKS"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectizeInput(inputId = "ticker",
                           label = "Ticker",
                           choices = c("Select a ticker" = "", tickers$symbol),
                           selected = "AAPL" ),
            dateInput(
                inputId = 'start_date',
                label = 'Start Date',
                value = "2021-01-01"),
            
            dateInput(
                inputId = 'end_date',
                label = 'End Date')
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotly::plotlyOutput("plot1"),
            DT::DTOutput('mytab1')
        )
    )
))
