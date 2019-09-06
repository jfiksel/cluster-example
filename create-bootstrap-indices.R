### Use this script to generate indices used for bootstrapping

### Set sample size
N <- 100

### Simulate and save data set
samp <- rnorm(100, mean = 10, sd = 3)
data_dir <- "data"
if(!dir.exists("data")){
    dir.create("data", recursive = TRUE)
}
saveRDS(samp, file.path(data_dir, "sim_data.rds"))

### Number of bootstrap repetitions
# Purposefully small for this example
B <- 100

### Initialize matrix of indices
indices <- matrix(NA, nrow = B, ncol = N)

### Must set seed for reproducibility
set.seed(123)
for(b in 1:B) {
    indices[b,] <- sample(1:N, replace = T)
}
### Save matrix
saveRDS(indices, file.path(data_dir, "indices.rds"))
quit('no')