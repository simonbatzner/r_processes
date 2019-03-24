#########################################################################
# Simon Batzner, MIT
#
# Gaussian Process Regression in R 
#
# Run GP. 
#########################################################################
rm(list=ls())
source(file="gp.r")
source(file="kernels.r")
set.seed(42)

# generate toy data 
n_samples.train = 100
n_samples.predict = 10
x.train = runif(n_samples.train, min = -10, max = 10)
y.train = 2 * cos(x.train) + rnorm(n_samples.train, mean = 0, sd = 1)
x.star = runif(n_samples.predict, min = -10, max = 10)
sigma.squared = 1

# predict
posterior <- gp.regression(x.train=x.train, y.train=y.train, kernel=se_kernel, sigma.squared=sigma.squared, x.star=x.star)
posterior.mean = posterior$mean
posterior.variance = posterior$variance

# plot 
gp.plot(posterior.mean=posterior.mean, posterior.variance=posterior.variance, x.train=x.train, y.train=y.train, x.star=x.star)

