### Note I know that I'm only passing in one argument here--in the case that 
### I'm passing in multiple, args would be a vector
boot.index <- as.numeric(commandArgs(trailingOnly = TRUE))


## Read in data and indices
data_dir <- "data"
samp <- readRDS(file.path(data_dir, "sim_data.rds"))
indices <- readRDS(file.path(data_dir, "indices.rds"))
boot.samp <- samp[indices[boot.index,]]
boot.mean <- mean(boot.samp)

## save file in bootstrap-results directory with file name "run-<boot.index>.rds"
if(!dir.exists("bootstrap-results")){
    dir.create("bootstrap-results", recursive = TRUE)
}
results.file <- file.path("bootstrap-results", paste0("run-", boot.index, ".rds"))
saveRDS(boot.mean, results.file)
## quit R and don't save workspace
quit('no')
