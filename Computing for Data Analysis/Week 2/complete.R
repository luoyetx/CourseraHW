complete <- function(directory, id = 1:322) {
  ids <- id
  id <- c()
  nobs <- c()
  it <- 0
  for (k in ids) {
    file <- paste(directory,paste(sprintf("%03d",as.integer(k)),'csv',sep="."),sep="/")
    data <- read.csv(file)
    good <- complete.cases(data)
    avail <- nrow(data[good,])
    it <- it+1
    id[it] <- k
    nobs[it] <- avail
  }
  data.frame(id, nobs)
}