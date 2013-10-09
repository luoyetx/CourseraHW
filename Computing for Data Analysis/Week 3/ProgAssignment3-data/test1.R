outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")
heart.attack <- as.numeric(outcome[,11])
hist(heart.attack, xlab="30-day Death Rate", main="Heart Attack 30-day Death Rate")