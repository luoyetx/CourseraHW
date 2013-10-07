corr <- function(directory, threshold=0) {
  files <- list.files(directory)
  correlation <- c()
  it <- 0
  for (file in files) {
    data <- read.csv(paste(directory,file,sep="/"))
    good <- complete.cases(data)
    data <- data[good, c("sulfate","nitrate")]
    if (nrow(data)>threshold) {
      it <- it+1
      correlation[it] <- cor(data$sulfate,data$nitrate)
    }
  }
  correlation
}