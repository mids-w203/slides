library(ggplot2)
library(dplyr)
library(data.table)
library(stargazer)
library(lfe)

setwd("/Volumes/GoogleDrive/My Drive/203 Redevelopment/slides/week_8/images")

theme_set(theme_minimal())

crime <- fread("crime_v2.csv")
## names(asec)

names(crime) <- tolower(names(crime))

summary(crime$crmrte)


names(crime)
m1 = lm(I(crmrte * 1000) ~ density + wfed + wser + wmfg , data = crime)
summary(m1)

mrestricted = lm(I(crmrte * 1000) ~ density , data = crime)
summary(mrestricted)

anova(m1,mrestricted)



rounder <- function(x) round(x)

stargazer(
    m1,
    type = 'latex', out = './crime.tex', float = FALSE,
    ## type = 'text',
    omit.stat = c('rsq', 'f', 'ser', 'adj.rsq'),
    digits = 3, 
    dep.var.caption = 'Dependent Variable: Crimes per 1000',
    dep.var.labels.include = FALSE,
    covariate.labels = c('Density', 'Federal Wage', 'Service Wage', 'Manufacturing wage', 'Intercept'),
    star.cutoffs = c(0.05, 0.01, 0.001),
    align = FALSE)
