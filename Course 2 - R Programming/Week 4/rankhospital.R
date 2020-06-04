rankhospital <- function(state, outcome, num = "best") {
  ## Read outcome data
  info <- read.csv(paste(getwd(), "/rprog_data_ProgAssignment3-data/outcome-of-care-measures.csv", sep = ""))
  
  ## Check that state and outcome are valid
  states <- unique(as.character(info[,7]))
  test1 <- which(state == states)
  if(length(test1) == 0) stop("invalid state")
  
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  test2 <- which(outcome == outcomes)
  if(length(test2) == 0) stop("invalid outcome")
  
  ## Return hospital name in that state with the given rank 30-day death rate
  hospinstate <- subset(info, State == state)
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
    num <- 1
  }
  else if(num == "worst") {
    num <- nrow(hospinstate)
  }
  print(hospinstate[num,2])
}