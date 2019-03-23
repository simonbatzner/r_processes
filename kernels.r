#########################################################################
# Simon Batzner, MIT
#
# Gaussian Process Regression in R 
#
# Collection of Kernels. Taken from David Duvenaud's 
# Kernel Cookbook: https://www.cs.toronto.edu/~duvenaud/cookbook/
#########################################################################
se_kernel <- function(x.1, x.2, length_scale = 1){
  # Computes the squared exponential kernel between two arguments
  #
  # Args:
  #   x.1: first scalar arguemnt
  #   x.2: second scalar argument
  #   length_scale: length scale
  #
  # Returns:
  #   The squared exponential kernel function, evaluted at x.1 and x.2
  return(exp(-(x.1 - x.2)^2/(2 * length_scale^2)))
} 

linear_kernel <- function(x.1, x.2, c = 0){
}

matern_kernel <- function(x.1, x.2, length_scale = 0){
}

periodic_kernel <- function(x.1, x.2, length_scale = 1, p = 1){
  # Computes the periodic kernel between two arguments
  #
  # Args:
  #   x.1: first scalar arguemnt
  #   x.2: second scalar argument
  #   length_scale: length scale
  #   p: periodicity
  #
  # Returns:
  #   The linear kernel function, evaluted at x.1 and x.2
  return(exp(-(2 * sin(pi * abs(x.1 - x.2) / p)^2)/(length_scale^2)))
} 
