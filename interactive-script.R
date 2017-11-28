set.seed(123)
samp <- rnorm(100, mean = 10, sd = 3)
B <- 100
bootstrap.means <- rep(NA, B)
for(i in 1:B){
    boot.samp <- samp[sample(length(samp), size = B, replace = TRUE)]
    bootstrap.means[i] <- mean(boot.samp)
}
hist(bootstrap.means)