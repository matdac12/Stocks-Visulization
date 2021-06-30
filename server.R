#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    current_ticker <- reactive({
        
        infile <- input$ticker
        
    })
    
    start_date <- reactive({
        infile<- input$start_date
    })
    
    end_date <- reactive({
        infile<- input$end_date
    })
    
    
    myplot <- reactive({
        data<- print(plot_stock_data(current_ticker(), start_date(), end_date()))
    })
    
    mytable <- reactive({
        data<- print(DT::datatable(get_stock_data(current_ticker(),start_date(),end_date()) %>% arrange(., desc(date)),options = list(pageLength = 30)))
    })

    output$plot1 <- plotly::renderPlotly({
        myplot()
    })
    
    output$mytab1 <- DT::renderDT({
        mytable()
    })

})
