data {
  int<lower=1> N;
  vector[N] X;
  vector[N] Y;
}
parameters {
  real alpha;
  real beta;
  real XtoYsigma;
  
  real Ymu;
  real Ysigma;
}
model {
  // Priors
  alpha ~ normal(0, 20);
  beta ~ normal(0, 20);
  XtoYsigma ~ exponential(1);
  
  Ymu ~ normal(0, 20);
  Ysigma ~ exponential(1);
  
  // Likelihoods
  Y ~ normal(alpha + beta*X, XtoYsigma);
  
  Y ~ normal(Ymu, Ysigma);
}
