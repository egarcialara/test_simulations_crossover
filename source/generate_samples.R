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
    b0=120, sigma_u=20, rho=0.75,
    treatment_effect=0.4, period_effect=0.03,
    do.random=FALSE
){
  
  # Generic values: treatment 0.4, period 0.03
  
  # Sequence in arrays: AB_P1, BA_P1, AB_P2, BA_P2
  # where A=control, B=treatment, P1/2=period 1/2
  n_per_group <- n_total/4
  # Patient random effect
  # b0, sigma_u as parameters
  # u_list <- rep(rnorm(n=n_per_group*2, mean=0, sd=sigma_u), 2)
  corr_matrix <- matrix(c(
    c(1, 0, rho, 0),
    c(0, 1, 0, rho),
    c(rho, 0, 1, 0),
    c(0, rho, 0, 1)
  ), 4, 4)
  Sigma <- corr_matrix * (sigma_u^2)
  u_matrix <- MASS::mvrnorm(n=n_per_group, mu=rep(0, 4), Sigma=Sigma)
  u_list <- as.vector(u_matrix)  # appends col1, then col2, etc
  
  # Period effect
  # P1=0, P2=pi
  g1_list <- c(rep(0, 2*n_per_group), rep(1, 2*n_per_group))
  mean_p <- period_effect*sigma_u
  if (!do.random){
    p_list <- rep(mean_p, n_total)  # option A: fixed  
  } else{
    sigma_p <- sigma_u/10
    p_list <- rnorm(n_total, mean=mean_p, sd=sigma_p)  # option B: random
  }
  
  # Treatment effect (per patient)
  g2_list <- c(rep(0, n_per_group), rep(1, n_per_group),
               rep(1, n_per_group), rep(0, n_per_group))
  mean_b <- treatment_effect*sigma_u
  if (!do.random){
    b_list <- rep(mean_b, n_total)  # option A: fixed
  } else{
    sigma_b <- sigma_u/5
    b_list <- rnorm(n_total, mean=mean_b, sd=4)  # option B: random
  }
  
  # Outcome
  Y_list <- b0 + g1_list*p_list + g2_list*b_list + u_list
  return(Y_list)
}
