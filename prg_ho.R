# A function that is able to generate n integers between min and max
random.int.generate <- function(n = 6, min = -10, max = 10){
  min <- as.integer(min)
  max <- as.integer(max)
  random_vector <- min:max
  random_int <- sample(random_vector, size = n, replace = FALSE)
  return(random_int)
}

# A function that is able to generate the result vector of N + M for the x_vector
generate.result.vector <- function() {
  x_j_vector <- rep(NA, times = length(random_int))
  N_plus_M_vector <- rep(NA, times = length(x_vector))
  for (j in 1:length(x_vector)) {
    x <- x_vector[j]
    for (i in 1:length(random_int)) {
      x_j_vector[i] <- x - sum(random_int[1:i])
    }
    x_j_N <- sum(x_j_vector >= high_threshold)
    x_j_M <- sum(x_j_vector <= low_threshold)
    x_j_N_plus_M <- x_j_N + x_j_M
    N_plus_M_vector[j] <- x_j_N_plus_M
  }
  return(N_plus_M_vector)
}

# Assign inputs
low_threshold <- 0L
high_threshold <- 25L
x_vector <- low_threshold:high_threshold
random_int <- random.int.generate()
N_plus_M_vector <- generate.result.vector()

# Find out X
answers_index <- which(N_plus_M_vector == min(N_plus_M_vector))
answers <- x_vector[answers_index]