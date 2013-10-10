best <- function(state, outcome) {
  ## Read outcome data
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  ## Check that state and outcome are valid
  if (sum(as.numeric(data$State == state)) == 0)
    stop("invalid state")
  outcome.valid <- c("heart attack", "heart failure", "pneumonia")
  if (sum(as.numeric(outcome.valid == outcome)) == 0)
    stop("invalid outcome")
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  cols <- if (outcome == "heart attack") c(2, 11)
          else if (outcome == "heart failure") c(2, 17)
          else c(2, 23)
  hospital <- data[data$State == state, cols]
  hospital[, 2] <- as.numeric(hospital[, 2])
  good <- is.na(hospital[, 2]) == F
  hospital <- hospital[good,]
  sel <- hospital[, 2] == min(hospital[, 2])
  sort(hospital[sel, 1])[1]
}