# Staircase
StairCase <- function(N){
  if (!N %in% 1:100) {
    print("Please input a integer that is between 1 and 100!")
  }
  else {
    for (i in 1:N) {
      print(paste(strrep(' ', times = N - i), strrep('#', times = i), sep = ''))
    }
  }
}

StairCase(N = 6)

# Sum them all
SumThemAll <- function(input_array){
  if (length(input_array) < 1 || length(input_array) > 10000) {
    print('Please input an array with length between 1 and 10,000!')
  }
  else {
    sum <- 0
    for (i in 1:length(input_array)) {
      sum <- sum + input_array[i]
    }
    return(sum)
  }
}

SumThemAll(1:5)
SumThemAll(c(12, 12))
