pollutantmean <- function(directory, pollutant, id=1:332) {
    p <- c()
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
        # clean NA
        bad <- is.na(data[[pollutant]])
        # append data to Vector p
        p <- c(p, data[!bad, pollutant])
    }
    # return mean of p
    mean(p)
}