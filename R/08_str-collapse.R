#' Collapse string of arguments and join them by '+'
#'
#' @param str_vector a vector of strings to be collapsed
#'
#' @return A string with the input parameters combined as a string, separated by '+'
#'
#' @export
#'
#' @examples
#' str_collapse("my name")
#' str_collapse(c("my name", "is", "jake"))
#' str_collapse(c("my name", "is", 2))
#' str_collapse(c(3, 2, "boy"))
#'
str_collapse <- function(str_vector) {
  if (!all(sapply(str_vector, is.character))) {
    stop("All items in 'str_vector' should be of class 'character'.")
  }
  paste(str_vector, collapse = " + ")
}
