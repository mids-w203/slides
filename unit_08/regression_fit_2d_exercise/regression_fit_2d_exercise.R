#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Fit a Regression Line with your Eyes"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput('beta_0',
                        'Set an intercept:',
                        min = -10, max = 20, value = 0), 
            sliderInput('beta_1', 
                        'Set a slope:', 
                        min = -10, max = 10, value = 0), 
            'Suppose that you observe the folowing data:',
            HTML('
            <ol>
              <li> You measure some x and y; and
              <li> You you arrange them with a basic scatter plot. 
            </ol>'), 
            'The plot of this data is shown below.', 
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h2('What line would you fit?'),
            'Suppose that you want to make predictions that are as 
            close to the truth as you can make them in the Y-dimension 
            subject subject to the restriction that you want Y to be 
            some linear function of the Xs.',
            'Fit a line onto the data that minimises the sum of the 
            squared residuals.',
           plotlyOutput('scatter'),
            h1('Distribution of Residuals'), 
            HTML('Here when we say <it> residuals </it> we mean the distance between the prediction and the outcome, measured vertically (in the y-dimension).'),
           plotlyOutput('histogram')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    core_data <- data.frame(
        x = runif(n = 50, min = 0, max = 10), 
        epsilon = rnorm(n = 50, mean = 0, sd = 2)) %>% 
        mutate(y = 5 + 2*x + epsilon)
    
    d_line_data_input <- reactive({
        data.frame(
            x = c(0, 10)) %>%  
            mutate(y = input$beta_0 + input$beta_1 * x)
    })
        
    d_data_input <- reactive({
        core_data %>%  
            mutate(y_hat = input$beta_0 + input$beta_1 * x) %>%  
            mutate(resid = y - y_hat)
        # data.frame(
        #     x = runif(n = 50, min = 0, max = 10),
        #     epsilon = rnorm(n = 50, mean = 0, sd = 2)) %>%  
        #     mutate(y = 5 + 2*x + epsilon) %>% 
        #     mutate(y_hat = input$beta_0 + input$beta_1 * x) %>%  
        #     mutate(resid = y - y_hat)
    })

    output$scatter <- renderPlotly({
        
        d_line <- d_line_data_input()
        d      <- d_data_input()
        
        d %>%  
            plot_ly() %>%  
            add_markers(x = ~x, y = ~y, mode = 'scatter', color = I('#003262')) %>%
            add_trace(data = d_line, x = ~x, y = ~y, mode = 'lines', color = I('#FDB515')) %>% 
            layout(
                xaxis = list(range = c(0,10)), 
                yaxis = list(range = c(0, 30)), 
                showlenged = FALSE
                )
            
        
    })
    
    output$histogram <- renderPlotly({
        
        d_line <- d_line_data_input()
        d      <- d_data_input()
        
        d %>% 
            plot_ly(x = ~resid, type = 'histogram', color = I('#003262')) %>% 
            layout(
                title = paste('MSE', round(mean(d$resid^2), 1)), 
                xaxis = list(
                    range = c(-20, 20)
                ))
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
