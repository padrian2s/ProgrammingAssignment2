## Below are two functions that are used to create a special object that stores a matrix and caches its inverse

## The first function, makeCacheMatrix creates a special list, which is really a function with the following
## capabilities:

## - set the value of the matrix
## - get the value of the matrix
## - set the value of the inverse
## - get the value of the inverse


## Usage or how to use this functionality:
##
## big_matrix <- matrix(c(9,9,8,0,8,7,7,0,6,6,5,0), nrow=4, ncol=3)
## cached_matrix <- makeCacheMatrix(big_matrix)
## cacheSolve(cached_matrix)

makeCacheMatrix <- function(x = matrix()) {
  # initial cache initialized with null
  cache <- NULL
  
  # get function
  getMatrix <- function() {
    x
  }
  
  # set function
  setMatrix <- function(newValue) {
    x <<- newValue
    cache <<- NULL
  }
  
  
  
  # cached get function
  getInverse <- function() {
    cache
  }
  
  # cache set function
  cacheInverse <- function(solve) {
    cache <<- solve
  }
  
  
  
  # return a list. Each element of the list is a function
  list(
    cacheInverse = cacheInverse,
    
    getMatrix = getMatrix,
    setMatrix = setMatrix,
    getInverse = getInverse
  )
}

# The following function calculates the mean of the special "matrix"
# created with the above function. However, it first checks to see if the inverse has already been calculated.
# If so, it gets the inverse from the cache and skips the computation.
# Otherwise, it calculates the inverse of the matrix and sets the value of the inverse in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
  inverse <- x$getInverse()
  
  if (!is.null(inverse)) {
    # we found a cache
    print("Cached inverse matrix was found. No compute this time...")
    return(inverse)
  }
  
  # no cache is found, do the whole inverse operation
  data <- x$getMatrix()
  inverse <- solve(data)
  x$cacheInverse(inverse)

  inverse
}
