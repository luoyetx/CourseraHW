rankall <- function(outcome, num = "best") {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  ## Check that state and outcome are valid
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia")))
    stop("invalid outcome")
  ## For each state, find the hospital of the given rank
  cols <- if (outcome == "heart attack") c(2, 7, 11)
    else if (outcome == "heart failure") c(2, 7, 17)
    else c(2, 7, 23)
  hospital <- data[, cols]
  hospital[,3] <- as.numeric(hospital[,3])
  hospital <- hospital[!is.na(hospital[,3]),]
  hospital.sorted <- hospital[order(hospital[,2],hospital[,3],hospital[,1]),]
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  if (num == "best") num <- 1
  states <- unique(hospital.sorted$State)
  result <- data.frame(hospital=c(NA), state=c(NA))
  for (state in states) {
    hospital.state <- hospital.sorted[hospital.sorted$State == state,]
    if (num == "worst") num.state <- nrow(hospital.state)
    else num.state <- num
    if (num.state > nrow(hospital.state))
      result[nrow(result)+1,] <- c(NA, state)
    else
      result[nrow(result)+1,] <- c(hospital.state[num.state,1],state)
  }
  result[2:nrow(result),]
}