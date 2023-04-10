#' Create a recipe object for modeling
#'
#' This function creates a recipe object for modeling based on the specified target variable and predictors.
#'
#' @param target_df A data frame containing the target variable and predictors.
#' @param target_variable A string specifying the name of the target variable.
#'
#' @return A recipe object for modeling.
#' @export
#'
#' @importFrom recipes recipe update_role step_scale step_center
#'
#' @include 01_target-df.R
#'
#' @examples
#' data("mtcars")
#' target_df <- target_df(mtcars, "gear", mpg, cyl, disp)
#' recipe <- create_recipe(target_df, "gear")
#'
#' @export
create_recipe <- function(target_df, target_variable){
  recipe <- recipes::recipe(~., data=target_df) %>%
    recipes::update_role(target_variable, new_role="outcome") %>%
    recipes::step_scale(all_predictors()) %>%
    recipes::step_center(all_predictors())
  #print("model recipe produced!")
  return(recipe)
}

