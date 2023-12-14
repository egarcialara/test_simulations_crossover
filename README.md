# Crossover trial simulations (private test code)

## This repository

```
.
├── data    # example samples for different scenarios (N=10000)
│           #    (with an example .Rmd notebook to explore them)
│   
└── source  # R code
```

## Data generation
For the example, Y is systolic blood pressure.

In the *parallel sample* we have 2 groups: treatment and control. Where treatment 
has a positive effect on the blood pressure.

$$
Y_i = b_0 + g_ib_i + u_i
$$

- i: patient
- $b_0$: mean in control
- $g_i$: vector if treatment
- $b_i$: treatment effect
- $u_i$: patient effect 

In the *crossover sample* there are 2 treatments (A=control, B=treatment), 2 sequences (AB, BA) and 2 periods (P1, P2). The possible combinations are then: AB_P1, BA_P1, AB_P2, BA_P2. 

$$
Y_{ij} = b0 + g1_j\pi + g2_{ij}b_T + u_{i} + w_{ij}
$$

- i: patient
- j: period
- $b_0$: mean in control
- $g1_j$: vector period (0=P1, 1=P2)
- $\pi$: period effect
- $g2_{ij}$: vector treatment (0=control, 1=treatment)
- $b_T$: treatment effect
- $u_{i}$: patient effect 
- $w_{ij}$: observation effect (repeated measurements)

Following the proposal example, the standardized treatment effect size is $b_T=0.4$. The overall variance is $20$ and the ratio of between/within subject variance is $2$.

Samples are generated in one go, with `MASS:mvrnorm`. 

## References
I took inspiration from...

Example basic: Urach et al (https://journals.sagepub.com/doi/10.1177/0962280218777896)





