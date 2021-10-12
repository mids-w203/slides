#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
if (!require('plotly')) install.packages('plotly')

library(shiny)
library(plotly) 

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("Fit a Regression Line with your Eyes"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        
        sidebarPanel(
            HTML('Suppose that you want to make predictions. Your goal  
            is to minimize the distance between predictions and truth, 
            measured in the Y-dimension. </br> </br> To make this a solvable problem, you 
            also add the restriction that your model for Y is some linear function 
            of the Xs. </br> </br> ', 
            'Using the toggles, fit a plane onto the data.', 
            'The points that you predict will be shown in Gold; the ground truth data in Blue.', 
            'Below is a histogram of the distribution of the residuals and the mean squared error.'),
            sliderInput('beta_0',
                        'Set an intercept:',
                        min = -10, max = 20, value = 0), 
            sliderInput('beta_1', 
                        'Set a slope for beta_1:', 
                        min = -10, max = 10, value = 0), 
            sliderInput('beta_2', 
                        'Set a slope for beta_2:', 
                        min = -10, max = 10, value = 0)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
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
        x_1 = runif(n = 50, min = 0, max = 10), 
        epsilon = rnorm(n = 50, mean = 0, sd = 2)) %>% 
        mutate(
            x_2 = 2 + x_1 + runif(n = 50, min = -5, max = 5)) %>%  
        mutate(y = 3 + 2*x_1 - 4 * x_2 + epsilon)
    

    d_line_data_input <- reactive({
        data.frame(
            expand.grid(
                x_1 = 0:10,
                x_2 = 0:20)) %>%
            mutate(y = input$beta_0 + input$beta_1 * x_1 + input$beta_2 * x_2)
        
    })
    
    d_data_input <- reactive({
        core_data %>%  
            mutate(y_hat = input$beta_0 + input$beta_1 * x_1 + input$beta_2 * x_2) %>%  
            mutate(resid = y - y_hat)
    })
    
    output$scatter <- renderPlotly({
        
        d_line <- d_line_data_input()
        d      <- d_data_input()
        
        plot_ly(data = d, x = ~x_1, y = ~x_2, z = ~y, color = I('#003262')) %>%
            add_markers(name = 'Ground Truth') %>%
            add_trace(data = d_line, x = ~x_1, y = ~x_2, z = ~y, mode = 'surface', color = I('#FDB515'), name = 'Predictions') %>%
            layout(
                xaxis = list(range = c(0,10)),
                yaxis = list(range = c(0, 30))
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
