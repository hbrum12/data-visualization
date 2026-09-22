#' Add two numbers
#'
#' @description This function adds two numbers together.
#' @param x This is the first number.
#' @param y This is a second number.
#' @return The sum of x and y.
test_add <- function(x, y) {
  return(x + y)
}

#' @description this function rescales numbers to 0-1 range
#' @param x a vector of numbers
#' @return rescaled x

rescale_to_01 <- function(x, na.rm = TRUE, finite = TRUE) {
  stopifnot(
    # safety check
    # stops the function if something is not true. what do we want to be true?
    "x must be a number!" = !missing(x) && rlang::is_bare_numeric(x),
    "na.rm must be a logical" = rlang::is_scalar_logical(na.rm)
  )
  rng <- range(x, na.rm = na.rm, finite = finite)
  rescaled_value <- (x - rng[1]) / (rng[2] - rng[1]) # body of function
  # variables defined inside a function cease to exist outside of the function, good way to keep code clean
  return(rescaled_value) # if you don't set a return, it returns what the function does last
}
