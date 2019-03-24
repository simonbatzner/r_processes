#########################################################################
# Simon Batzner, MIT
#
# Gaussian Process Regression in R 
# 
# Core GP functions: regress and plot
#########################################################################
library(plotly)

gp.regression <- function(x.train, y.train, kernel, sigma.squared, x.star){
  # following p.19 on Rasmussen, Williams
  k.xx <- outer(x.train, x.train, kernel)
  k.x.x.star <- outer(x.train, x.star, kernel)
  k.x.star.x <- t(k.x.x.star)
  k.x.star.x.star <- outer(x.star, x.star, kernel)

  # cholesky decomposition (kernel matrix is hermitian)
  # L is an upper triangular matrix 
  L <- chol(k.xx + diag(sigma.squared, length(x.train)))
  
  # solve for alpha
  alpha <- backsolve(L, forwardsolve(t(L), y.train)) #Solve Ab = y efficiently in two steps
  
  # posterior mean
  posterior.mean <- k.x.star.x %*% alpha
  
  # predictive variance
  v <- forwardsolve(t(L), k.x.x.star)
  posterior.var <- k.x.star.x.star - t(v) %*% v
  
  out <- list("mean" = posterior.mean, "variance" = posterior.var)
  return(out)
  
}

gp.plot <- function(posterior.mean, posterior.variance, x.train, y.train, x.star){
  post.sd <- sqrt(diag(posterior.variance))
  two.sigma.upper <- posterior.mean + 2 * post.sd
  two.sigma.lower <- posterior.mean - 2 * post.sd
  
  data.train <- data.frame(x.train, trace=y.train)
  data.test <- data.frame(x.star, trace=posterior.mean)
  
  x.star = x.star[order(x.star)]
  two.sigma.upper = two.sigma.upper[order(x.star)]
  two.sigma.lower = two.sigma.lower[order(x.star)]
  
  plot_ly(x = ~x.train, y = y.train, type='scatter', mode='markers', name='Training Data') %>%
          add_lines(x = x.star, y = ~posterior.mean, name = 'Posterior Mean')   %>%
          add_ribbons(x = x.star, y = posterior.mean, ymin = two.sigma.lower, ymax = two.sigma.upper)
}



