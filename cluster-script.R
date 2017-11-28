library(getopt)
args <- commandArgs(trailingOnly = TRUE)
hh <- paste(unlist(args), collapse = " ")
listoptions <- unlist(strsplit(hh, "--"))[-1]
options.args <- sapply(listoptions, function(x) {
  unlist(strsplit(x, " "))[-1]
})

boot.index <- options.args[1]
## B is number of bootstrap repetitions
B <- 100
## set initial seed for reproducibility 
set.seed(123)
samp <- rnorm(100, mean = 10, sd = 3)
## set seed for this specific run
boot.seed <- sample(1e6, size = B, replace = F)[as.numeric(boot.index)]
set.seed(boot.seed)
boot.samp <- samp[sample(length(samp), size = B, replace = TRUE)]
boot.mean <- mean(boot.samp)

## save file in bootstrap-results directory with file name "run-<boot.index>.rds"
results.file <- file.path("bootstrap-results", paste0("run-", boot.index, ".rds"))
saveRDS(boot.mean, results.file)
## quit R and don't save workspace
quit('no')
