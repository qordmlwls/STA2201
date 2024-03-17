//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N;
  int y[N];
  vector[N] log_e;
  vector[N] x;
}

parameters {
  real alpha;
  real beta;
}

transformed parameters {
  vector[N] log_theta;
  
  log_theta = alpha + beta*x;
}

model {
  y ~ poisson_log(log_theta + log_e);
  alpha ~ normal(0,1);
  beta ~ normal(0,1);
}