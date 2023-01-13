library(dplyr)
library(ggplot2)

pop_var <- function(x) { 
  mean((x - mean(x))^2)
  }


d <- data.frame(
  id = 1:150000
)

d <- d %>%  
  mutate(
    group = rep(c('Atlanta', 'Baltimore','Chicago'), each = 50000),
    bad_group = sample(c('Wash.', 'Oregon', 'California'), size = 150000, replace = TRUE),
    wage = c(
      rnorm(n = 50000, mean =  80, sd = 10), 
      rnorm(n = 50000, mean = 100, sd = 10), 
      rnorm(n = 50000, mean = 120, sd = 10)
    )
  )

d %>%  
  ggplot(aes(x = wage)) + 
  geom_density(size = 1) + 
  theme_minimal(base_size = 20) + 
  theme(
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank()
  )
ggsave('./images/gaussian_mixture.pdf', device = 'pdf', bg = 'transparent')


d %>% 
  ggplot(aes(x = wage)) + 
  facet_grid(rows = vars(group)) + 
  geom_density(size = 1) + 
  theme_minimal(
    base_size = 20) + 
  theme(
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank()
  )
ggsave(
  filename = './images/split_gaussian.pdf', 
  device = 'pdf', 
  bg = 'transparent'
  )

d %>% 
  ggplot(aes(x = wage)) + 
  facet_grid(rows = vars(bad_group)) + 
  geom_density(size = 1) + 
  theme_minimal(
    base_size = 20,
    ) + 
  theme(
    axis.text.y  = element_blank(),
    axis.ticks.y = element_blank()
  )
ggsave(
  filename = './images/bad_split_gaussian.pdf', 
  device = 'pdf', 
  bg = 'transparent'
)

d %>%  
  summarise(
    variance = var(wage)
  )

d %>% 
  group_by(bad_group) %>%  
  summarise(
    variance_within = pop_var(wage), 
    expectation_within = mean(wage)) %>%  
  mutate(
    variance_of_expectation = pop_var(expectation_within))
