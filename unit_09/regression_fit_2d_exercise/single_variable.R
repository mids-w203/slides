library(tidyverse)
library(plotly)

beta_0 <- 0
beta_1 <- 1

## Create data for line, based on input data
d_line <- data.frame(
  x = c(0, 10)) %>%  
  mutate(y = beta_0 + beta_1 * x)

## Create data for scatter plot
d <- data.frame(
  x = runif(n = 50, min = 0, max = 10),
  epsilon = rnorm(n = 50, mean = 0, sd = 2)) %>%  
  mutate(y = 1 + 2*x + epsilon) %>% 
  mutate(y_hat = beta_0 + beta_1 * x) %>%  
  mutate(resid = y - y_hat)

## Plot scatter and line 
d %>%  
  plot_ly() %>%  
  add_markers(x = ~x, y = ~y, mode = 'scatter')  %>%  
  add_trace(data = d_line, x = ~x, y = ~y, mode = 'lines')

## Plot Histogram 
d %>% 
  plot_ly(x = ~resid, type = 'histogram')


