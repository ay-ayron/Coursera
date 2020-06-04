rankall <- function(outcome, num = "best") {
  ## Read outcome data
  info <- read.csv(paste(getwd(), "/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", sep = ""))
  
  ## Check that outcome is valid
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  test2 <- which(outcome == outcomes)
  if(length(test2) == 0) stop("invalid outcome")
  
  ## For each state, find the hospital of the given rank
  hosprankings <- data.frame(hospital=character(), state=character())
  states <- unique(as.character(info[,7]))
  
  for (i in 1:length(states)) {
    hospinstate <- subset(info, State == states[i])
    hospinstate[,11] <- suppressWarnings(as.numeric(hospinstate[,11]))
    hospinstate[,17] <- suppressWarnings(as.numeric(hospinstate[,17]))
    hospinstate[,23] <- suppressWarnings(as.numeric(hospinstate[,23]))
    
    if(outcome=="heart attack") {
      hospinstate <- hospinstate[order(hospinstate[,11], hospinstate[,2]),]
      hospinstate <- hospinstate[complete.cases(hospinstate[ , 11]),]
    }
    else if(outcome=="heart failure") {
      hospinstate <- hospinstate[order(hospinstate[,17], hospinstate[,2]),]
      hospinstate <- hospinstate[complete.cases(hospinstate[ , 17]),]
    }
    else if(outcome=="pneumonia") {
      hospinstate <- hospinstate[order(hospinstate[,23], hospinstate[,2]),]
      hospinstate <- hospinstate[complete.cases(hospinstate[ , 23]),]
    }
    
    if(num == "best") {
      j <- 1
    }
    else if(num == "worst") {
      j <- nrow(hospinstate)
    }
    else {
      j <- num
    }
    hosprankings[i,1] <- hospinstate[j,2]
    hosprankings[i,2] <- states[i]
  }
  
  ## Return a data frame with the hospital names and the 
  ##(abbreviated) state name
  hosprankings <- hosprankings[order(hosprankings[,2]),]
}