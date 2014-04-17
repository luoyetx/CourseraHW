corr <- function(directory, threshold=0) {
    corrs <- c()
    id <- 1:332
    for (index in id) {
        # read csv file
        c_index <- as.character(index)
        if (nchar(c_index)==1) {
            c_index <- paste("00", c_index, sep="")
        } else if (nchar(c_index)==2) {
            c_index <- paste("0", c_index, sep="")
        }
        f <- paste(directory, "/", c_index, ".csv", sep="")
        data <- read.csv(f)
        # count complete
        good <- complete.cases(data$sulfate, data$nitrate)
        # compute
        if (sum(good) > threshold) {
            corrs <- c(corrs, cor(data$sulfate, data$nitrate, use="complete.obs"))
        } else {
            next
        }
    }
    # return corrs
    corrs
}