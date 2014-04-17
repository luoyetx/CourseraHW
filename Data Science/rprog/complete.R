complete <- function(directory, id=1:332) {
    nobs <- c()
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
        # append data
        nobs <- c(nobs, sum(good))
    }
    # return data.fram
    data.frame(id=id, nobs=nobs)
}