library(cmdstanr)


# linear relation between X and Y
true_alpha <- 0
true_beta <- 1

# X population info
Xtrue_mean <- 0
Xtrue_sd <- 1

# strength of association between X and Y
XtoYtrue_sd <- 1

# sample size
N <- 10000

X <- rlnorm(N, 
           mean = Xtrue_mean, sd = Xtrue_sd)
Y <- rnorm(N,
           mean = true_alpha + true_beta*X, sd = XtoYtrue_sd)X
plot(X, Y,
     main = "Association between Y and X",
     xlab = "X", ylab = "Y")
plot(density(Y),
     main = "Distribution of Y",
     xlab = "Y Value", ylab = "Density")


model <- cmdstanr::cmdstan_model(stan_file = "/Users/todd/Code/Fun/Pearson's Uncertainty/linear_model.stan")

data <- list(N = N,
             X = X,
             Y = Y)

fit <- model$sample(data = data,
                    iter_warmup = 1000, iter_sampling = 5000,
                    chains = 4, parallel_chains = 4)

draws <- fit$draws(format = "df")

plot(density(1 - draws$XtoYsigma^2 / draws$Ysigma^2),
     main = "R^2 Estimate")
abline(v = cor(X,Y)^2,
       lty = "dashed", col = "red")
