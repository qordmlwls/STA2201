data {
  int<lower=0> N; // number of observations
  int<lower=0> T; //number of years
  vector[N] y; //log ratio
  vector[N] se; // standard error around observations
  vector[T] years; // unique years of study
  int<lower=0> year_i[N]; // year index of observations
  int<lower=0> P; // number of years to project
  
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  vector[T] mu;
  real<lower=0> sigma; // variance of random walk
}


model {
  // taking into account measurement error
  y ~ normal(mu[year_i], se);
  
  mu[1] ~ normal(0, 1);
  mu[2:T] ~ normal(mu[1:(T-1)], sigma);
  sigma ~ normal(0, 1);
}

generated quantities {
  vector[P] mu_p;
  mu_p[1] = normal_rng(mu[T], sigma);
  for (i in 2:P){
    mu_p[i] = normal_rng(mu_p[i-1], sigma);
  }
  
}
