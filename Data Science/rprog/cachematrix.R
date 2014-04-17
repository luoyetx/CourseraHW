## cachematrix.R provide two functions to help cache
## the inverse of a square invertible matrix
## which is once computed and used repeatedly :-)


## provide interfaces with the cached maxtrix

makeCacheMatrix <- function(x = matrix()) {
    ## :param x: assumed as a square invertible matrix

    # inverse of matrix x
    inverse <- NULL
    # set a new matrix
    set <- function(y) {
        x <<- y
        inverse <<- y
    }
    # get matrix
    get <- function() { x }
    # set inverse
    setInverse <- function(o) { inverse <<- o }
    # get inverse
    getInverse <- function() { inverse }
    
    list(set=set, get=get,
         setInverse=setInverse, getInverse=getInverse)
}


## calculate the inverse of matrix provided by makeCacheMatrix

cacheSolve <- function(x, ...) {
    ## :param x: a matrix created by function makeCacheMatrix
    ## :param ...: extra parameters pass to function solve()

    # try to get inverse
    inverse <- x$getInverse()
    if (!is.null(inverse)) {
        # get cached inverse
        message("get cached inverse")
    } else {
        # compute and cache inverse
        mat <- x$get()
        inverse <- solve(mat, ...)
        x$setInverse(inverse)
    }
    # return inverse
    inverse
}
