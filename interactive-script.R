### Always set seed for reproducibility
set.seed(123)
### Generate random sample (note in real life we would read in our data set in this step)
N <- 100
samp <- rnorm(100, mean = 10, sd = 3)
B <- 100
bootstrap.means <- rep(NA, B)

indices <- matrix(NA, nrow = B, ncol = N)

### Must set seed for reproducibility
set.seed(123)
for(b in 1:B) {
    indices[b,] <- sample(1:N, replace = T)
}

for(b in 1:B){
    boot.samp <- samp[indices[b,]]
    bootstrap.means[b] <- mean(boot.samp)
}
hist(bootstrap.means)
ggplot.df <- data.frame(index = 1:length(bootstrap.means), mean = bootstrap.means)
library(ggplot2)
ggplot(ggplot.df, aes(mean)) +
  geom_density()