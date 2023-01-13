library(ggplot2)
library(magrittr)

d <- data.frame(
  x = rexp(1000, rate = 2)
)
d$y <- (d$x + 2)^2.2 + rnorm(1000)

d %>%  
  ggplot(aes(x=x, y=y)) + 
  geom_hex() + 
  theme_minimal() + 
  labs(
    x = 'x-axis', y = 'y-axis'
  )

ggsave(filename = 'hex.pdf', device = 'pdf', bg = 'transparent')