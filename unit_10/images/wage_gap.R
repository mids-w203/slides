library(ggplot2)
library(dplyr)
library(data.table)
library(stargazer)
library(lfe)

theme_set(theme_minimal())

asec <- fread("pppub19.csv.gz")
## names(asec)

names(asec) <- tolower(names(asec))

ft <- asec[prwkstat == 2,]

ft[ , a_sex := as.factor(a_sex)]
summary(ft$wsal_val)

ft[wsal_val < 0, wsal_val := NA]
ft[ , hist(wsal_val)]

ft[ , t.test(wsal_val ~ a_sex)]

ft[a_sex == 2, mean(wsal_val)]

ft[ , .(average_earnings = mean(wsal_val)), keyby = a_sex]

ft %>%
    ggplot(aes(x = wsal_val / 1000, fill = a_sex)) +
    geom_density(alpha = 0.4, color = NA) + 
    scale_fill_manual(
        name = NULL,
        values = c("#003262", "#FDB515"),
        labels = c("Men","Women")) +
    xlim(0, 250) +
    labs(
        x = 'Total Wage and Salary (Thousands of $)',
        y = 'Density',
        title = 'Women Earn Less than Men') + 
    theme(
        legend.position = c(.95, .95),
        legend.justification = c("right", "top"),
        legend.box.just = "right",
        legend.margin = margin(6, 6, 6, 6),
        axis.text.y = element_blank())
ggsave("wage_hist.pdf",
       device='pdf',
       units = 'mm', width = 128, height = 96,
       bg = 'transparent')

ft[ , sex_f := factor(a_sex, levels = c(1,2), labels = c('Male', 'Female'))]

mod <- ft[ , lm(wsal_val / 1000 ~ sex_f)]

ft %>%
    sample_n(1000) %>%
    ggplot(aes(x = sex_f, y = wsal_val / 1000, color = sex_f)) + 
    geom_jitter(width=.2, height=0, alpha = 1) +
    geom_abline(
        slope = coef(mod)[2],
        intercept = coef(mod)[1],
        color = 'darkred') + 
    scale_color_manual(
        values = c("#003262", "#FDB515")) +     
    ylim(0,250) +
    labs(
        x = NULL,
        y = 'Total Wage and Salary (Thousands of $)',
        title = 'Regression View of Wage Gap',
        subtitle = 'Random Subset of 1,000 Data Points') +
    theme(legend.position = 'none')
ggsave("wage_slope.pdf",
       device = 'pdf',
       units = 'mm', width = 96, height = 96,
       bg = 'transparent')


m1 = lm(wsal_val ~ a_sex, data = ft)

rounder <- function(x) round(x)

stargazer(
    m1,
    type = 'latex', out = './model_female.tex', float = FALSE,
    ## type = 'text',
    omit.stat = c('rsq', 'f', 'ser', 'adj.rsq'),
    digits = 0, 
    dep.var.caption = 'Dependent Variable: Pay',
    dep.var.labels.include = FALSE,
    covariate.labels = c('Female', 'Intercept'),
    star.cutoffs = c(0.05, 0.01, 0.001),
    align = FALSE)

ft[ , occup := as.factor(occup)]
length(levels(ft$occup))


m2 <- ft[ , lm(wsal_val ~ a_sex + occup)]
m3 <- ft[ , felm(wsal_val ~ a_sex | occup)]

stargazer(
    m1, m2, 
    type = 'latex', out = './model_female_occupation.tex', float = FALSE,
    ## type = 'text',
    omit = "occup",
    add.lines = list(
        c('Occupation FE', 'No', 'Yes', 'Yes')
        ), 
    omit.stat = c('rsq', 'f', 'ser', 'adj.rsq'),
    digits = 0, 
    dep.var.caption = 'Dependent Variable: Pay',
    dep.var.labels.include = FALSE,
    covariate.labels = c('Female', 'Intercept'),
    model.names = FALSE,
    star.cutoffs = c(0.05, 0.01, 0.001),
    align = FALSE)


stargazer(
    m1, m2, 
    type = 'latex', out = './model_female_occupation_alt.tex', float = FALSE,
    ## type = 'text',
    omit.stat = c('rsq', 'f', 'ser', 'adj.rsq'),
    digits = 0, 
    dep.var.caption = 'Dependent Variable: Pay',
    dep.var.labels.include = FALSE,
    covariate.labels = c('Female', 'Intercept'),
    model.names = FALSE,
    star.cutoffs = c(0.05, 0.01, 0.001),
    align = FALSE)


1- (15035 / mean(ft[ft$a_sex==1,]$wsal_val))


hist(ft$PEHRUSLT, breaks=50)


summary(ft$a_age)
hist(ft$a_age)
head(ft$a_age)
t.test(ft$a_age ~ ft$a_sex)


# m4 = ft[ , felm(wsal_val ~ a_sex + a_age | occup)]
m4 = lm(wsal_val ~ a_sex + a_age + I(a_age^2) + occup, data = ft)


stargazer(
    m1, m2, m4,
    type = 'latex', out = './model_female_occupation_age.tex', float = FALSE,
    ## type = 'text',
    omit = "occup",
    omit.stat = c('rsq', 'f', 'ser', 'adj.rsq'),
    digits = 0, 
    dep.var.caption = 'Dependent Variable: Pay',
    dep.var.labels.include = FALSE,
    covariate.labels = c('Female', 'Age', 'Age^2', 'Intercept'),
    add.lines = list(
        c('Occupation FE', 'No', 'Yes', 'Yes')
    ), 
    model.names = FALSE,
    star.cutoffs = c(0.05, 0.01, 0.001),
    align = FALSE
)





   
m5 = lm(wsal_val ~ a_sex * a_age + occup, data = ft)


stargazer(
    m5,
    type = 'latex', out = './model_female_occupation_interaction.tex', float = FALSE,
    ## type = 'text',
    omit = "occup",
    omit.stat = c('rsq', 'f', 'ser', 'adj.rsq'),
    digits = 0, 
    dep.var.caption = 'Dependent Variable: Pay',
    dep.var.labels.include = FALSE,
    covariate.labels = c('Female', 'Age', 'Female:Age', 'Intercept'),
    add.lines = list(
        c('Occupation FE', 'No', 'Yes', 'Yes')
    ), 
    model.names = FALSE,
    star.cutoffs = c(0.05, 0.01, 0.001),
    align = FALSE
)
