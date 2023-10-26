library(cmdstanr)

model <- cmdstanr::cmdstan_model("/Users/todd/Code/Learning/PFU Poisson CI/poisson_model.stan")

fit <- model$sample(iter_sampling = 5e3)

draws <- fit$draws(format = "df")

plot(density(draws$stock_concentration))

