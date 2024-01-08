# Crossover trial simulations (private test code)

## This repository

```
.
├── data    # example samples for different scenarios (N=10000)
│           #    (with an example .Rmd notebook to explore them)
│   
├── docs    # more details about crossover code
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



## References
Example basic: Urach et al (https://journals.sagepub.com/doi/10.1177/0962280218777896)





