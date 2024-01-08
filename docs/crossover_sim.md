In the *crossover sample* there are 2 treatments (A=control, B=treatment), 2 sequences (AB, BA) and 2 periods (P1, P2). The possible combinations are then: AB_P1, BA_P1, AB_P2, BA_P2. 

# Simulation

$$
Y_{ij} = \alpha + g1_{ij}\tau + g2_{ij}\pi + g3_{ij}c + e_{ij}
$$

- i: patient
- j: period

- $\alpha$: mean in control
- $g1_{ij}$: vector treatment (0=control, 1=treatment)
- $\tau$: treatment effect
- $g2_{ij}$: vector period (0=P1, 1=P2)
- $\pi$: period effect
- $g3_{ij}$: vector carryover (0=AB_P1,AB_P2,BA_P1; 1=BA_P2)
- $c$: carryover effect

## Variance
Option A: compound symmetry

$$
\displaylines{
e_i = (e_{i1}, e_{i2})\\
e_i \sim \mathcal{N}(0, \Sigma_i)\\
\Sigma_i = \begin{bmatrix}
1 & \rho \\
\rho & 1
\end{bmatrix} * \sigma^2
}
$$

Also (for me)

$$
\displaylines{
e_{ij} = u_i + w_{ij} \\
u_i \sim\mathcal{N}(0, \sigma_u) \\
w_{ij} \sim\mathcal{N}(0, \sigma_w) \\
\rho = \frac{\sigma_u^2}{\sigma_u^2\sigma_w^2} \\
\Sigma_i = \begin{bmatrix}
1 & \rho \\
\rho & 1
\end{bmatrix} * (\sigma_u^2 + \sigma_w^2) = 
\begin{bmatrix}
\sigma_u^2 + \sigma_w^2 & \sigma_u^2 \\
\sigma_u^2 & \sigma_u^2 + \sigma_w^2
\end{bmatrix}
}
$$

- $u_{i}$: patient effect 
- $w_{ij}$: observation effect (repeated measurements)


Ref:
Design issues in crossover trials involving patients with Parkinson’s disease
David Sparrow

## Code, in practice
Following the proposal example, the standardized treatment effect size is $\tau=0.4$. 

The overall variance ($\sigma^2$) is $20$ and the ratio of between/within subject variance ($\sigma_u/\sigma_w$) is $2$ (i.e. $\rho = 2/3$).

Samples from both sequences are generated in one go, with `MASS:mvrnorm`. 
Then, the sigma introduced is 

```
corr_matrix <- matrix(c(
  c(1, rho, 0, 0),
  c(rho, 1, 0, 0),
  c(0, 0,   1, rho),
  c(0, 0,   rho, 1)
), 4, 4)
Sigma <- corr_matrix * (sigma_T^2)
```

# Parameter estimation
2 options: mixed model, classic t-test





