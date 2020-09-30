library(ggplot2)
library(gtools)

set.seed(4)

d <- data.frame(
  x = runif(n = 100, min = 0, max = 10)
)
d$y <- logit(d$x, min = 0, max = 10) + rnorm(100, mean = 0, sd = 0.5)

source('./pubPlot.R')

pdf('./images/logit0.pdf', bg = 'transparent', height = 5, width = 10)
source('./pubPlot.R')
plot(
  d$y, d$x, col = '#003262', 
  xlab = NA, ylab = NA)
dev.off()

pdf('./images/logit1.pdf', bg = 'transparent', height = 5, width = 10)
source('./pubPlot.R')
plot(
  d$y, d$x, col = '#003262', 
  xlab = NA, ylab = NA)
lines(lowess(d$y, d$x), col = '#FDB515', lwd = 3)
dev.off()

