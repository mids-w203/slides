skews <- seq(0.5, 4, by = 0.1)

for(i in 1:length(skews)) { 
  
  error_rate <- mean(
    replicate(
      10000, 
      t.test(
        rgamma(
          20, 
          shape=(2/skews[i])^2, 
          scale=1/(2/skews[i])^2
          ), 
        mu=1)$p.value <.05)
    )
  
  pdf(file = paste0('~/Desktop/gamma_skew_', i, '.pdf'), height = 5, width = 10)
  source('http://ischool.berkeley.edu/~d.alex.hughes/code/pubPlot.R')
  
    curve(
      dgamma(
      x = x, 
      shape=(2/skews[i])^2, 
      scale=1/(2/skews[i])^2
    ), 
    from= -1, to= 4, 
    ylim=c(0,2), 
    ylab='', xlab = '',
    yaxt = 'n', n = 1000, 
    main = sprintf('Gamma Distribution with Skew: %.1f', skews[i])
  )
    text(x = 3, y = 1, labels = sprintf('False Positive Rate: \n %.3f', error_rate), cex = 2)
    dev.off()
}