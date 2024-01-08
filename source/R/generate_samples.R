##############
## PARALLEL ##
##############
generate.samples.parallel <- function(
    n_total, 
    b0=120, sigma_u=20,
    treatment_effect=0.4){
  
  n_control <- n_total/2
  n_treat <- n_total/2
  
  # b0, sigma_u as parameters
  u_list <- rnorm(n=n_total, mean=0, sd=sigma_u)
  
  # draw for all n, then mult by 0...
  g_list <- c(rep(0, n_control), rep(1, n_treat))
  
  mean_b <- treatment_effect*sigma_u
  b_list <- rep(mean_b, n_total)  # option A: fixed
  # b_list <- rnorm(n_total, mean=mean_b, sd=4)  # option B: random
  
  Y_list <- b0 + g_list*b_list + u_list
  return(Y_list)
}




###############
## CROSSOVER ##
###############
generate.samples.crossover <- function(
    n_total, 
    b0=120, sigma_T=20, rho=0.667,
    treatment_effect=0, period_effect=0,
    carryover_effect=0
){
  # Defaults
  # treatment_effect=0.4, period_effect=0.03,
  # carryover_effect=0.1
  
  # Sequences (in order): AB_P1, AB_P2, BA_P1, BA_P2
  # where A=control, B=treatment, P1/2=period 1/2
  n <- n_total/4
  
  # Treatment effect 
  # A=0, B=tau
  mean_t <- treatment_effect*sigma_T
  
  # Period effect
  # P1=0, P2=pi
  mean_p <- period_effect*sigma_T

  # Carry over effect
  mean_c <- carryover_effect*sigma_T

  # Patient random effect
  # rho, sigma_T as parameters
  # mean is 0
  # AB_P1, AB_P2, BA_P1, BA_P2
  corr_matrix <- matrix(c(
    c(1, rho, 0, 0),
    c(rho, 1, 0, 0),
    c(0, 0,   1, rho),
    c(0, 0,   rho, 1)
  ), 4, 4)
  Sigma <- corr_matrix * (sigma_T^2)
  
  # Outcome
  # AB_P1, AB_P2, BA_P1, BA_P2
  Y_matrix <- MASS::mvrnorm(n=n, 
                            mu=c(b0,
                                 b0+mean_p+mean_t,
                                 b0+mean_t, 
                                 b0+mean_p+mean_c),
                            Sigma=Sigma)
  Y_list <- as.vector(Y_matrix) # appends col1, then col2, etc
  
  return(Y_list)
}
