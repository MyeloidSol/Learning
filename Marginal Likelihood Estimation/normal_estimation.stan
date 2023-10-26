data {
  int N;
  vector[N] x;
}
parameters {
  real mu;
}
model {
  // Prior
  mu ~ normal(0, 100);
  
  // Likelihood
  x ~ normal(mu, 1);
}
