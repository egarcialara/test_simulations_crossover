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

In the *crossover sample* there are 4 groups: AB_P1, BA_P1, AB_P2, BA_P2. 
There, AB and BA are the groups, and P1 and P2 the 2 periods. A corresponds to control
and B to treatment.

$$
Y_{ij} = b0 + g1_j\pi_j + g2_{ij}b_i + u_i
$$

- j: period
- $\pi$: period effect


## References
I took inspiration from...

Example basic: Urach et al (https://journals.sagepub.com/doi/10.1177/0962280218777896)





