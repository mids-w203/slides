library(dplyr)
library(ggplot2)

theme_set(theme_minimal())

d <- data.frame(
  id = 1:1000
)


d <- d %>%  
  mutate(x = rbinom(n = 1000, size = 1, prob = 2/3)) %>%  
  mutate(y = rnorm(n = 1000, mean = 10 + (30*x), sd = 5))

d %>%  
  ggplot(aes(x = x)) + 
  geom_histogram()

d %>%  
  ggplot(aes(x = y)) + 
  geom_histogram()

d %>%  
  ggplot(aes(x = 1, y = y)) + 
  geom_jitter(alpha = 0.2, height = 0) + 
  geom_boxplot(alpha = 0.5)

d %>%  
  ggplot(aes(x = as.factor(x), y = y)) + 
  geom_jitter(width = .2, height = 0, alpha = 0.2) + 
  geom_boxplot(mapping = aes(y = y, group = x), alpha = 0.5)



hist(d$x)
hist(d$y)

