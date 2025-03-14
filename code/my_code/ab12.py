from scipy.stats import poisson
import numpy as np
from sympy import Lambda

lambd = 288 * np.log(2)
alpha = poisson.ppf(0.95, lambd)  # Percentile function for Poisson
print(alpha)

# the result is 223.0
