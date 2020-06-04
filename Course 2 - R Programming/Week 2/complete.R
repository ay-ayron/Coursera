complete <- function(directory, id = 1:332) {
  #Initialize empty dataframe
  no.ofmonitors <- length(id)
  df <- data.frame(id = integer(), nobs=integer())
  
  #Fill in dataframe with monitor id and number of cases
  for (i in 1:no.ofmonitors) {
    path <- paste(getwd(), '/', directory, '/', sprintf("%03d", id[i]), ".csv", sep = "")
    temp <- read.csv(path)
    df[i,] <- c(id[i], nrow(na.omit(temp)))
  }
  print(df)
}