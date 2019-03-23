# r_processes

Gaussian Processes in R. 

### Requirements

R 3.5.2+

### Getting Started
```
$ git clone git@github.com:simonbatzner/r_processes.git
$ rscript run_gp.r 
```

### Example

```
# generate toy data 
n_samples.train = 100
n_samples.predict = 10
x.train = runif(n_samples.train, min = -10, max = 10)
y.train = 2 * cos(x.train) * sin(x.train) + rnorm(n_samples.train, mean = 0, sd = 1)
x.star = runif(n_samples.predict, min = -10, max = 10)
sigma.squared = 1

# predict
posterior <- gp.regression(x.train=x.train, y.train=y.train, kernel=periodic_kernel, sigma.squared=sigma.squared, x.star=x.star)
posterior.mean = posterior$mean
posterior.variance = posterior$variance
```


