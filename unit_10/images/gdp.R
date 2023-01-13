getwd()
setwd("~/Desktop")
library(ggplot2)
theme_set(theme_minimal(base_size = 14))

load("Countries3.RData")
summary(Countries$gdp)


####################################################
######## Logs
####################################################


ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100))
ggsave("gdp1.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')


ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm, color="darkred", se=F)+
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100))
ggsave("gdp2.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')



ggplot(Countries, aes(x=log(gdp), y=internet_users_2011)) + 
  geom_point(shape=18)+
#  geom_smooth(method=lm, color="darkred", se=F)+
  xlab("ln(GDP per capita)") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100))
ggsave("gdp3.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')


ggplot(Countries, aes(x=log(gdp), y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm, color="darkred", se=F)+
  xlab("ln(GDP per capita)") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100))
ggsave("gdp4.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')

  
ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm,formula= (y ~ log(x)), color="darkred", se=F) +
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100))
ggsave("gdp5.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')



summary(lm(internet_users_2011 ~ gdp, data = Countries))
summary(lm(internet_users_2011 ~ log10(gdp), data = Countries))
summary(lm(internet_users_2011 ~ log(gdp), data = Countries))


ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm,formula= (y ~ log(x)), color="darkred", se=F) +
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100)) 

ggsave("gdp6.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')




####################################################
######## Polynomials
####################################################

poly_for = function(n, x, y){
  c = paste(y,"~",x)
  for (i in 2:n){
    c = paste(c, "+ I(",x,"^", as.character(i),")", sep="")
  }
  return(c)
}
poly_for(4, "gdp", "internet_users_2011" )


summary(lm(formula = poly_for(2, "gdp", "internet_users_2011"), data = Countries))
summary(lm(formula = poly_for(3, "gdp", "internet_users_2011"), data = Countries))
summary(lm(formula = poly_for(10, "gdp", "internet_users_2011"), data = Countries))
summary(lm(formula = poly_for(30, "gdp", "internet_users_2011"), data = Countries))



ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm,formula= (y ~ x + I(x^2)), color="darkred", se=F) +
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100))

ggsave("gdp7.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')



ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm,formula= (y ~ x + I(x^2)), aes(color="2, R² = .66"), se=F) +
  geom_smooth(method=lm,formula= (y ~ x + I(x^2) + I(x^3)), aes(color="3, R² = .67"), se=F) +
#  geom_smooth(method=lm,formula= poly_for(30, "x", "y" ), aes(color="30, R² = .73"), se=F) +
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100)) +
  theme(
    legend.position = c(.95, .05),
    legend.justification = c("right", "bottom"),
    legend.box.just = "right",
    legend.margin = margin(6, 6, 6, 6)
  ) +
  scale_colour_manual(name="Polynomial Order", values=c("red", "darkred", "purple")) 
  
  
ggsave("gdp9.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')



ggplot(Countries, aes(x=gdp, y=internet_users_2011)) + 
  geom_point(shape=18)+
  geom_smooth(method=lm,formula= (y ~ x + I(x^2)), aes(color="2, R² = .66"), se=F) +
  geom_smooth(method=lm,formula= (y ~ x + I(x^2) + I(x^3)), aes(color="3, R² = .67"), se=F) +
  geom_smooth(method=lm,formula= poly_for(30, "x", "y" ), aes(color="30, R² = .73"), se=F) +
  xlab("GDP per capita") + ylab("Internet Users per 100") +
  scale_y_continuous(limits = c(0, 100)) +
  theme(
    legend.position = c(.95, .05),
    legend.justification = c("right", "bottom"),
    legend.box.just = "right",
    legend.margin = margin(6, 6, 6, 6)
  ) +
  scale_colour_manual(name="Polynomial Order", values=c("red", "darkred", "purple")) 


ggsave("gdp10.pdf", device='pdf', units = 'mm', width = 128, height = 96, bg='transparent')

