# Display the Student's t distributions with various
# degrees of freedom and compare to the normal distribution

x <- seq(50, 140, length=100)
s1 <- dnorm(x, 110, 10)
s2 <- dnorm(x, 130, 10)
s3 <- dnorm(x, 90, 10)
st <- s1+s2+s3

data = c( rnorm(1000, 110, 10), rnorm(1000, 130, 10), rnorm(1000, 90, 10) )
var(data)

cond_means = c(110,130,90)
var(cond_means) * 2/3

par(mfrow=c(1,1), mai = c(.6, .1, 0.5, 0.1))
plot(x, st, type="l", xlab="Salary ($ thousands)", main="Marginal Distribution of Salary", axes=F)
axis(1, seq(60, 140, 20))




par(mfrow=c(3,1), mai = c(.6, 0.1, 0.1, 0.1))
plot(x, s1, type="l", axes=F,  ann=FALSE)
title("S | O = data scientist", line = -2, adj = 0.1, cex.main=1.9)
axis(1, seq(50, 150, 20), cex.axis=1.5)
plot(x, s2, type="l", axes=F,  ann=FALSE)
title("S | O = data engineer", line = -2, adj = 0.1, cex.main=1.9)
axis(1, seq(50, 150, 20), cex.axis=1.5)
plot(x, s3, type="l", axes=F,  ann=FALSE)
title("S | O = data analyst", line = -2, adj = 0.1, cex.main=1.9)
axis(1, seq(50, 150, 20), cex.axis=1.5)
