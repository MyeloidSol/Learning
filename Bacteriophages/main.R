require(parallel)
require(dplyr)


# Generate Test Data ----
N <- rpois(1, lambda = 1e7) # Total number of bacteriophages produced

# Divide up work among cluster
cl <- makeCluster(detectCores() - 1)
clN <- round(N / length(cl)) 
clusterExport(cl, "clN")

# Bacteriophages inputted into experiment
data <- clusterEvalQ(cl, {
  # Count number of times unique bacteriophage pops up over clN iterations
  cl_input <- replicate(clN, paste(sample(letters[1:20], 5, T), collapse = "")) |> 
    table() |> # Frequency table
    as.data.frame()
  
  colnames(cl_input) <- c("ident", "iN")
  
  cl_input
})
stopCluster(cl)

# Merge data from different nodes
data <- bind_rows(data) |> 
  group_by(ident) |> # Merge rows by ident column
  summarise_all(sum) # Add iN column

# Simulate stochastic dissociation
input$counts <- rbinom(nrow(data), 
                       size = input$iN,
                       p = 0.1)
