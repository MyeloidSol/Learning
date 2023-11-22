data {
}

parameters {
  real<lower = 0> plate_concentration;
}
transformed parameters {
  real<lower=0> stock_concentration;
  stock_concentration = plate_concentration * 1e7;
}
model {
  int plaques_counted = 109;
  real volume_plated = 0.1; // in mL
  
  plate_concentration ~ uniform(0, 1e15);
  plaques_counted ~ poisson(plate_concentration * volume_plated);
}

