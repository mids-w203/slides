library(ggplot2)
library(magrittr)

theme_set(theme_minimal(base_size = 20))

options(repr.plot.width=2, repr.plot.height=2, dpi = 300)

d_00 <- data.frame(
  x = c(rep(0,100),rep(1,100)),
  y = rnorm(200)
)

d_00 %>% 
    ggplot(aes(x = x, y = y)) + 
    geom_jitter(width = 0.1, size = 3) + 
    geom_smooth(method='lm',formula=y~x, se = FALSE) + 
    scale_x_continuous(breaks=c(0,1)) +
    scale_y_continuous(limits = c(-3, 8)) + 
    labs(
        x = 'Group', 
        y = NULL, 
        title = 'Correlation: 0.0') +
    theme(
        panel.background = element_rect(fill = "transparent", color = NA),
        plot.background  = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent", color = NA)
        )
ggsave('./biserial_00.pdf', device = 'pdf', bg = 'transparent')

## Correlation: 0.5 

d_05 <- data.frame(
  x = c(rep(0,100),rep(1,100)),
  y = c(rnorm(100, mean = 0), rnorm(100, mean = 1))
)

d_05 %>% 
    ggplot(aes(x = x, y = y)) + 
    geom_jitter(width = 0.1, size = 3) + 
    geom_smooth(method='lm',formula=y~x, se = FALSE) + 
    scale_x_continuous(breaks=c(0,1)) +
    scale_y_continuous(limits = c(-3, 8)) + 
    labs(
        x = 'Group', 
        y = NULL, 
        title = 'Correlation: 0.5')  +
    theme(
        panel.background = element_rect(fill = "transparent", color = NA),
        plot.background  = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent", color = NA)
    )
ggsave('./biserial_05.pdf', device = 'pdf', bg = 'transparent')

d_09 <- data.frame(
    x = c(rep(0,100),rep(1,100)),
  y = c(rnorm(100, mean = 0), rnorm(100, mean = 5))
)

d_09 %>% 
    ggplot(aes(x = x, y = y)) + 
    geom_jitter(width = 0.1, size = 3) + 
    geom_smooth(method='lm',formula=y~x, se = FALSE) + 
    scale_x_continuous(breaks=c(0,1)) +
    scale_y_continuous(limits = c(-3, 8)) + 
    labs(
        x = 'Group', 
        y = NULL, 
        title = 'Correlation: 0.9')  +
    theme(
        panel.background = element_rect(fill = "transparent", color = NA),
        plot.background  = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent", color = NA)
    )
ggsave('./biserial_09.pdf', device = 'pdf', bg = 'transparent')
