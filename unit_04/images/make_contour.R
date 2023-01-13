library(ggplot2)
library(magrittr)
library(MASS)
library(dplyr)

d <- data.frame(
  x = rnorm(n = 5000, mean = 0, sd = 4),
  w = rnorm(n = 5000, mean = 0, sd = 4)
)

d$y <- 2*d$x + d$w

contours <- kde2d(x = d$x, y = d$y, h = 4, n = 100)

d %>%  
  ggplot(aes(x = x, y = y)) + 
  geom_density_2d() + 
  theme_minimal()

ggsave(filename = 'contour.pdf', device = 'pdf', bg = 'transparent')
  