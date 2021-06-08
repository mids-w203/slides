library(ggplot2)
library(dplyr)
library(magrittr)

person_attributes <- data.frame(
    id = 1:1000,
    left_handed = sample(
        x = c('right handed', 'left handed'),
        size = 1000, replace = TRUE, prob = c(0.9, 0.1))
    )

left_strength <- data.frame(
    id = 1:1000,
    hand = 'left',
    strength = rnorm(1000, mean = 10, sd = 5) 
    )

right_strength <- data.frame(
    id = 1:1000,
    hand = 'right',
    strength = ifelse(
        person_attributes[ , 'left_handed'] == 'right handed',
        left_strength[ , 'strength'] + rnorm(1000, mean = 2),
        left_strength[ , 'strength'] + rnorm(1000, mean = -.2)
    )
)

d_tall <- rbind(
    merge(person_attributes, left_strength),
    merge(person_attributes, right_strength)
    )

wide_left <- merge(person_attributes, left_strength)
names(wide_left)[4] <- 'strength_left'
wide_left <- wide_left[ , c('id', 'left_handed', 'strength_left')]

wide_right <- merge(person_attributes, right_strength)
names(wide_right)[4] <- 'strength_right'
wide_right <- wide_right[ , c('id', 'strength_right')]

d_wide <- merge(
    wide_left, wide_right,
    by = 'id'
)


d_tall %>%
    filter(left_handed == 'right handed') %>%
    ggplot(
        aes(x = strength, y = after_stat(density), fill = factor(hand))) +
    geom_histogram(position = 'dodge', bins = 10) +
    scale_fill_manual(values = c('#003262', '#3B7EA1')) + 
    ## facet_wrap( ~ factor(left_handed)) +
    scale_x_continuous(limits = c(-10, 30)) + 
    labs(fill = 'Hand') +
    theme(
        panel.background = element_rect(fill = "transparent", color = NA),
        plot.background  = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent", color = NA)
        )
ggsave('./histogram_unpaired.pdf', device = 'pdf', bg = 'transparent')


d_wide %>%
    filter(left_handed == 'right handed') %>% 
    mutate(strength_difference = strength_right - strength_left) %>%
    ggplot() +
    aes(x = strength_difference) +
    geom_histogram(position = 'dodge', fill = '#003262') +
    labs(fill = 'Hand') +
    ## scale_x_continuous(limits = c(-10, 30)) + 
    theme(
        panel.background = element_rect(fill = "transparent", color = NA),
        plot.background  = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent", color = NA)
        )
ggsave('./histogram_paired.pdf', device = 'pdf', bg = 'transparent')

d_wide %>%
    mutate(strength_difference = strength_right - strength_left) %>% 
    ggplot(aes(x = strength_difference)) +
    geom_histogram(bins = 100, fill = '#003262') +
    scale_x_continuous(limits = c(-10, 25)) + 
    labs(fill = 'Hand') + 
    theme(
        panel.background = element_rect(fill = "transparent", color = NA),
        plot.background  = element_rect(fill = "transparent", color = NA),
        legend.background = element_rect(fill = "transparent", color = NA)
        )
ggsave('./histogram_paired_rescaled.pdf', device = 'pdf', bg = 'transparent')

## Conduct t-tests

d_tall %>%
    filter(left_handed == 'right handed') %$%
    t.test(strength ~ hand)

d_wide %>%
    filter(left_handed == 'right handed') %$%
    t.test(strength_left, strength_right, paired = TRUE)
