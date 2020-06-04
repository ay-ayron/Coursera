corr <- function(directory, threshold = 0) {
  #Initialize empty dataframe to track threshold data
  df <- c()
  path <- paste(getwd(), '/', directory, sep = "")
  fils <- list.files(path)
  no.ofmonitors <- length(fils)
  j <- 0
  
  #
  for (i in 1:no.ofmonitors) {
    path <- paste(getwd(), '/', directory, '/', fils[i], sep = "")
    temp <- read.csv(path)
    temp <- na.omit(temp)
    if(nrow(temp) > threshold) {
      j <- j+1
      df[j] <- cor(temp[['sulfate']],temp[['nitrate']])
    }
  }
  df
}