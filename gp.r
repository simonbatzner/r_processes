#########################################################################
# Simon Batzner, MIT
#
# Gaussian Process Regression in R 
# 
# Core GP functions: regress and plot
#########################################################################
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
  v <- forwardsolve(L, k.x.x.star)
  posterior.var <- k.x.star.x.star - t(v) %*% v
  
  out <- list("mean" = posterior.mean, "variance" = posterior.var)
  return(out)
  
}


gp.plot <- function(x.test, y.test, y.pred, pred.std){
  
}



