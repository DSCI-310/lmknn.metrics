#' Get List Item
#'
#' This function retrieves the nth element of a given list.
#'
#' @param list_object A list.
#' @param n The index of the element to retrieve.
#'
#' @return The nth element of the input list.
#'
#' @examples
#' my_list <- list(a = 1, b = 2, c = 3)
#' get_list_item(my_list, 2)
#'
#' @export

get_list_item <- function(list_object, n){
  if (!is.numeric(n) | n < 1){
    stop("n has to be an integer > 0!")
  }
  return(list_object[[n]])
}