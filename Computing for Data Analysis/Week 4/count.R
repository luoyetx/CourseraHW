count <- function(cause = NULL) {
  ## Check that "cause" is non-NULL; else throw error
  if (is.null(cause)) stop("cause shouldn't be NULL")

  ## Check that specific "cause" is allowed; else throw error
  if (!(cause %in% c("asphyxiation", "blunt force", "other", "shooting", "stabbing", "unknown")))
    stop("wrong cause")

  ## Read "homicides.txt" data file
  homicides <- readLines("homicides.txt")

  ## Extract causes of death
  index <- regexec("<dd>Cause: (.*?)</dd>", homicides)
  result <- sapply(regmatches(homicides, index), function(x) tolower(x[2]))
  # Remove NA
  result <- result[!is.na(result)]

  ## Return integer containing count of homicides for that cause
  result <- result[result == cause]
  length(result)
}