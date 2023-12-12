##############
## VARIANCE ##
##############
get.var.within.crossover <- function(Y){
  # Variance within patients
  # Sequence in arrays: AB_P1, BA_P1, AB_P2, BA_P2
  
  n_total <- length(Y)
  n <- n_total/4
  group1 <- Y[1:n] # 1st group
  group2 <- Y[(n+1):(2*n)] # 2nd group
  group3 <- Y[(2*n+1):(3*n)] # 3rd group
  group4 <- Y[(3*n+1):(4*n)] # 4th group
  
  return((
    sum((group3 - group1)^2) + 
      sum((group4 - group2)^2)
  ) / (n_total-1))
  
}