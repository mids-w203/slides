d <- data.frame(
  x_small = rnorm(100, mean = 0, sd = 1), 
  x_large = rnorm(100, mean = 0, sd = 10)
)

d['y_small'] <- d['x_small'] + rnorm(100, mean = 0, sd = 1)
d['y_large'] <- d['x_large'] + rnorm(100, mean = 0, sd = 10)

pdf(file = './covariance_plot.pdf', height = 5, width = 10)
source(file = 'http://ischool.berkeley.edu/~d.alex.hughes/code/pubPlot.R')
par(mfrow = c(1,2))
plot(
  x = d[ , 'x_small'], y = d[ , 'y_small'], 
  xlim = c(-25, 25), ylim = c(-25, 25), 
  xlab = NA, ylab = NA,
  pch = 19, 
  main = sprintf('Covariance: %.2f', cov(d$x_small, d$y_small))
  )
plot(
  x = d[ , 'x_large'], y = d[ , 'y_large'], 
  xlim = c(-25, 25), ylim = c(-25, 25), 
  xlab = NA, ylab = NA,
  pch = 19, 
  main = sprintf('Covariance: %.2f', cov(d$x_large, d$y_large))
  )
dev.off()

pdf(file = './correlation_plot.pdf', height = 5, width = 10)
source(file = 'http://ischool.berkeley.edu/~d.alex.hughes/code/pubPlot.R')
par(mfrow = c(1,2))
plot(
  x = d[ , 'x_small'], y = d[ , 'y_small'], 
  xlim = c(-25, 25), ylim = c(-25, 25), 
  xlab = NA, ylab = NA,
  pch = 19, 
  main = sprintf('Correlation: %.2f', cor(d$x_small, d$y_small))
  )
plot(
  x = d[ , 'x_large'], y = d[ , 'y_large'], 
  xlim = c(-25, 25), ylim = c(-25, 25), 
  xlab = NA, ylab = NA,
  pch = 19, 
  main = sprintf('Correlation: %.2f', cor(d$x_large, d$y_large))
)
dev.off()