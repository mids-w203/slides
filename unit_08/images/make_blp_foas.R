library(data.table) 
library(ggplot2)
library(magrittr)

d <- data.table(
  y = c(6.88, 1.17, 16.16, -4.84, -6.17, 0.67, 3.36, -0.69, 8.03, -3.35, 1.87, 13.54, 4.06, 6.72, 7.20), 
  x = c(1.37, 0.30, 1.57, -0.69, -0.64, 0.08, 0.47, 1.33, -0.13, 0.59, -0.44, -0.76, 0.73, -3.54, -0.05)
)

d %>% 
  ggplot(aes(x=x,y=y)) + 
  geom_point() + 
  scale_x_continuous(limits = c(-4,4)) + 
  scale_y_continuous(limits = c(-20, 20)) + 
  theme_minimal()
ggsave('blp_foas_scatter.pdf', device = 'pdf', bg = 'transparent')

d %>% 
  ggplot(aes(x=x,y=y)) + 
  geom_point() + 
  geom_segment(x = -4, xend = 4, y = -7, yend = 9, color = 'black') + 
  scale_x_continuous(limits = c(-4,4)) + 
  scale_y_continuous(limits = c(-20, 20)) + 
  theme_minimal()
ggsave('blp_foas_scatter_cef.pdf', device = 'pdf', bg = 'transparent')

d %>%  
  ggplot(aes(x=x,y=y)) + 
  geom_point() + 
  geom_segment(x = -4, xend = 4, y = 2, yend = 5, color = 'red') + 
  geom_segment(x = -4, xend = 4, y = -7, yend = 9, color = 'black') + 
  scale_x_continuous(limits = c(-4,4)) + 
  scale_y_continuous(limits = c(-20, 20)) + 
  theme_minimal()  
ggsave('blp_foas_scatter_cef_blp.pdf', device = 'pdf', bg = 'transparent')