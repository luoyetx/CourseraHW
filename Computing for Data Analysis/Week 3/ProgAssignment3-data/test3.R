require(graphics)
outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")
death <- as.numeric(outcome[,11])
state <- outcome$State
par(las=2)
state.factor <- reorder(state, death, FUN=median, na.rm=TRUE)
boxplot(death ~ state.factor, ylab="30-day Death Rate", main="Heart Attack 30-day Death Rate by State")