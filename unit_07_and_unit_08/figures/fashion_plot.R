
library(tidyverse)
ggtheme(minimal)
x = seq(11,14,by=.01)
D = data.frame(x=x)
D$'1.00' = dnorm(D$x,mean=12.5, sd=1)
D$'0.50' = dnorm(D$x,mean=12.5, sd=.5)
D$'0.05' = dnorm(D$x,mean=12.5, sd=.05)
D = data.frame(x = D$x, stack(D, select = c('1.00','0.50','0.05')) ) 
names(D) = c('x','values', 'sd')

 D %>% ggplot(aes(x=x, y=values)) +
  geom_line(aes(color = sd)) + 
   facet_grid(sd ~ ., scales = "free_y", labeller = label_both) + 
   expand_limits(y = 0) + 
   ylab('probability density') +
   geom_vline(xintercept = 12.1) + geom_vline(xintercept = 13.3)  + 
   theme_minimal() +
 theme(legend.position = "none") 
 
 ggsave('fashion_plot.png')
 