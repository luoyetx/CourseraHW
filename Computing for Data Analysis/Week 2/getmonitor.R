getmonitor <- function(id, directory, summarize=F) {
  file <- paste(directory,paste(sprintf("%03d",as.integer(id)),"csv",sep="."),sep="/")
  data <- read.csv(file)
  if (summarize) {
    summary(data)
  }
  data
}