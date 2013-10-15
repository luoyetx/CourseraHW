agecount <- function(age = NULL) {
  ## Check that "age" is non-NULL; else throw error
  if (is.null(age)) stop("age shouldn't be NULL")

  ## Read "homicides.txt" data file
  homicides <- readLines("homicides.txt")

  ## Extract ages of victims; ignore records where no age is
  ## given
  index <- regexec(" ([0-9]+) years old", homicides)
  result <- sapply(regmatches(homicides, index), function(x) as.integer(x[2]))
  # remove na
  result <- result[!is.na(result)]

  ## Return integer containing count of homicides for that age
  result <- result[result == age]
  length(result)
}