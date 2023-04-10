#' Selects target variable and additional columns from a dataframe
#'
#' @param df a dataframe
#' @param target_variable a character string representing the target variable
#' @param ... additional columns to select from the dataframe
#'
#' @return a dataframe with only the target variable and the additional columns selected
#' @export
#'
#' @import dplyr
#'
#' @examples
#' # Selecting only the target variable
#' target_df(mtcars, "mpg")
#'
#' # Selecting the target variable and additional columns
#' target_df(mtcars, "mpg", cyl, disp)
#'
#' @export
target_df <- function(df, target_variable, ...){
  df <- df %>% dplyr::select(target_variable, ...)
  #print("target df produced!")
  return(df)
}
