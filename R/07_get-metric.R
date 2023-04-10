#' Get metric from a prediction model
#'
#' Extracts a specified metric from a prediction model.
#'
#' @param prediction_model A dataframe with predicted values appended to target_test_df.
#' @param metric The name of the metric to assess performance of the prediction model.
#'   Supported metrics include "rmse", "rsq", and "mae".
#' @param target_variable The name of the target variable of the prediction model.
#'
#' @return The specified metric value.
#' @export
#'
#' @importFrom yardstick metrics
#'
#' @include 06_create-model-prediction.R
#'
#' @examples
#' train_df <- target_df(mtcars[1:16, ], 'gear', c("am", "vs"))
#' test_df <- target_df(mtcars[17:32, ], 'gear', c("am", "vs"))
#' x_recipe <- create_recipe(train_df, target_variable="gear")
#' x_spec_list <- create_spec_kmin(train_df, model_recipe=x_recipe, method="lm", target_variable="gear")
#' x_spec <- get_list_item(x_spec_list, n=1)
#' x_fit <- create_fit(x_recipe, x_spec, train_df)
#' prediction_model <- create_model_prediction(test_df, x_fit )
#' get_metric(prediction_model, "rmse", "gear")
#'
get_metric <- function(prediction_model, metric, target_variable){

  if (!(inherits(prediction_model, "data.frame"))){
    stop("prediction_model must be a dataframe!")
  }

  if(!(metric %in% c("rmse", "rsq", "mae"))){
    stop("Please input a valid metric")
  }

  if(!(target_variable %in% colnames(prediction_model))){
    stop("target_variable not found in prediction_model!")
  }

  metric_result <- prediction_model %>%
    yardstick::metrics(truth=target_variable, estimate=.pred) %>% #rmse, rsq and mae metrics generated
    dplyr::filter(.metric==metric) %>%
    dplyr::select(.estimate) %>%
    dplyr::pull()
  #print("Metric extracted")
  return(metric_result)
}
