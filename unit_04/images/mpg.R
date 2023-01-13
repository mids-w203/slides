library(ggplot2)
setwd("~/Desktop")

theme_set(theme_minimal(base_size = 14))


ggplot( mtcars, aes(x=hp, y=mpg) ) +
  geom_density_2d() +
  xlab("horsepower") +
  ggtitle("Estimated Joint Distribution: Fuel Efficiency of Cars")

ggsave("mpg.pdf",
       device='pdf',
       units = 'mm', width = 128, height = 96,
       bg = 'transparent')


ggplot( mtcars, aes(x=hp, y=mpg) ) +
  geom_density_2d() +
  geom_smooth(method = "loess", color ="gold", se=F)+
  xlab("horsepower") 

ggsave("mpg_cef.pdf",
       device='pdf',
       units = 'mm', width = 128, height = 96,
       bg = 'transparent')

ggplot( mtcars, aes(x=hp, y=mpg) ) +
geom_density_2d() +
  geom_smooth(method = "lm", color ="red", se=F)+
  xlab("horsepower") 

ggsave("mpg_lm.pdf",
       device='pdf',
       units = 'mm', width = 128, height = 96,
       bg = 'transparent')

ggplot( mtcars, aes(x=hp, y=mpg) ) +
  geom_density_2d() +
  xlab("horsepower") +
  geom_point(aes(x=mean(mtcars$hp), y=mean(mtcars$mpg)), shape = 4, size = 5,colour="darkred")

ggsave("mpg_mean.pdf",
       device='pdf',
       units = 'mm', width = 128, height = 96,
       bg = 'transparent')

# Area + contour
ggplot( faithful, aes(x=waiting, y=eruptions) ) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", colour="white")
