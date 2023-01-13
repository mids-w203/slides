getwd()
setwd("~/Desktop")
library(ggplot2)
theme_set(theme_minimal(base_size = 14))
library(datasets)

summary(faithful)

ggplot(data = mtcars, aes(x=hp, y=mpg)) +
  geom_point() +xlab("Horsepower") + ylab("Mpg") +
  ggtitle("Performance of Cars (1974 Motor Trend)") +
  theme(plot.title = element_text(hjust = 0.5))

ggsave("cars.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')
