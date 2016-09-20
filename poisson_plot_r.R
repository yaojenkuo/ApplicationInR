library(ggplot2)

# Poisson density distribution with mu = 2
N <- 10000
mu <- 2
pois <- rpois(N, lambda = mu)
pois_df <- data.frame(pois)
pois_plot <- ggplot(pois_df, aes(x = pois)) + 
  geom_line(stat = 'density', adjust = 3) + 
  ggtitle(paste('Poisson distribution, lamda =', mu))
pois_plot

# An empty vector to store means
means_vector <- rep(NA, times = 5000)

# Take a sample of n = 2 from the Poisson density, repeat 5,000 times
for (i in 1:length(means_vector)) {
  means_vector[i] <- mean(sample(pois, size = 2, replace = TRUE))
}

# Plot this 5,000 times
means_df <- data.frame(means = means_vector)
means_plot <- ggplot(means_df, aes(x = means)) +
  geom_line(stat = 'density', adjust = 3) +
  ggtitle('Frequency Distribution of the Means')
means_plot

# Prepare a data frame with Poisson and Normal data points
data <- rnorm(N, mean = mu, sd = sqrt(mu))
dist <- rep("Normal", times = 10000)
norm_df <- data.frame(data, dist)
dist <- rep("Poisson", times = 10000)
pois_df <- cbind(pois_df, dist)
names(pois_df)[1] <- "data"
pois_norm_df <- rbind(norm_df, pois_df)

# Add the normal distribution to the plot
overlapped_plot <- ggplot(pois_norm_df, aes(x = data, fill = dist)) + 
  geom_density(alpha = 0.3, adjust = 3) + 
  ggtitle('Normal Distribution Added')
overlapped_plot