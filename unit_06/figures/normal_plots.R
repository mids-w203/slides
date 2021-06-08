x_low  <- seq(-4, qnorm(0.025), by = 0.01)
x_high <- seq(qnorm(0.975), 4,  by = 0.01)

pdf(file = '~/Desktop/normal_with_two_tails.pdf', height = 5, width = 10)
source('http://ischool.berkeley.edu/~d.alex.hughes/code/pubPlot.R')
curve(
  dnorm, 
  from = -4, to = 4, 
  ylab = NA, xlab = NA,
  main = 'Normal Distribution', 
  xlim = c(-5, 5), 
  yaxt = 'n'
)
polygon(
  x = c(x_low, rev(x_low)), 
  y = c(dnorm(x = x_low), rep(0, length(x_low))),
  col = 'darkorange'
)
polygon(
  x = c(x_high, rev(x_high)), 
  y = c(dnorm(x = x_high), rep(0, length(x_high))), 
  col = 'darkorange'
)
text(x = 3,  y = 0.05, labels = expression(frac(alpha, 2)))
text(x = -3, y = 0.05, labels = expression(frac(alpha, 2)))
dev.off()


x_high <- seq(qnorm(0.95), 4,  by = 0.01)

pdf(file = '~/Desktop/normal_with_one_tail.pdf', height = 5, width = 10)
source('http://ischool.berkeley.edu/~d.alex.hughes/code/pubPlot.R')
curve(
  dnorm, 
  from = -4, to = 4, 
  ylab = NA, xlab = NA,
  main = 'Normal Distribution', 
  xlim = c(-5, 5), 
  yaxt = 'n'
)
polygon(
  x = c(x_high, rev(x_high)), 
  y = c(dnorm(x = x_high), rep(0, length(x_high))), 
  col = 'darkorange'
)
text(x = 3,  y = 0.05, labels = expression(alpha))
dev.off()

