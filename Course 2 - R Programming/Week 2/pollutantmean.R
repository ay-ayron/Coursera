pollutantmean <- function(directory, pollutant, id = 1:332) {
  #create an empty vector
  no.ofmonitors <- length(id)
  data <- c()

  #add desired pollutant values from desired monitors to empty vector
  for (i in 1:no.ofmonitors) {
    path <- paste(getwd(), '/', directory, '/', sprintf("%03d", id[i]), ".csv", sep = "")
    temp <- read.csv(path)
    data <- append(data, temp[[pollutant]])
  }
  
  #output mean of desired pollutant excluding NA
  if(pollutant == 'sulfate') {
    sprintf("The mean %s is %f ug/m^3", pollutant, mean(data, na.rm = TRUE))
    }
  else if(pollutant == 'nitrate') {
    sprintf("The mean %s is %f ug/m^3", pollutant, mean(data, na.rm = TRUE))
    }
  else {
    sprintf("Desired pollutant was not measured")
  }
}