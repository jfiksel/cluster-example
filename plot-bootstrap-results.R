bootstrap.files <- list.files("bootstrap-results", full.names = TRUE)
## use lapply if you saved something other than a single number in each run
results <- sapply(bootstrap.files, readRDS)

### you can also do jpeg, png, etc...
pdf("bootstrap-histogram.pdf")
hist(results)
dev.off()

## example with ggplot2 and ggsave
library(ggplot2)
ggplot.df <- data.frame(index = 1:length(results), mean = results)
ggplot.hist <-
  ggplot(ggplot.df, aes(mean)) +
  geom_histogram()
ggsave(filename = "bootstrap-histogram-ggplot.pdf",
       plot = ggplot.hist)
quit('no')