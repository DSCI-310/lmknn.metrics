#' Create a dataframe of performance metrics for a prediction model
#'
#' @description
#' This function takes as input two data frames: train_df and test_df that contain the training and test data for a prediction model, respectively. It also takes a character string specifying the performance metric to calculate "metric", a character string specifying the prediction model to use "method", an integer specifying the minimum number of neighbors to consider when using the "kknn" method "kmin", a character string specifying the name of the target variable in the data frames target_variable, and a character vector specifying the names of the predictor variables in the data frames "predictors_vector". The function returns a data frame containing the specified performance metric, the predictor variables, the prediction model method, and the value of kmin "if applicable".
#'
#' @details
#' The function calculates the specified performance metric :"rmse", "rsq", or "mae" for the prediction model specified by the method argument: "lm" or "kknn".
#' If the method argument is "kknn", the function uses the kmin argument to determine the minimum number of neighbors to consider if "kmin" variable is not specified.
#' If the kmin argument is not specified it is set to "NA".
#' The function assumes that the target variable and predictor variables have already been identified in the data
#'
#'
#' @param train_df A data frame containing the training data for the prediction model
#' @param test_df A data frame containing the test data for the prediction model
#' @param metric A character string specifying the performance metric to calculate "rmse", "rsq", or "mae"
#' @param method A character string specifying the prediction model to use lm" or "kknn"
#' @param kmin An integer specifying the minimum number of neighbors to consider when using the "kknn" method  - ignored if "lm" method is used
#' @param target_variable A character string specifying the name of the target variable in the data frames
#' @param predictors_vector A character vector specifying the names of the predictor variables in the data frames

#'
#' @return A data frame containing the specified performance metric, the predictor variables, the prediction model method, and the value of kmin i"f applicable"
#' @export
#'
#' @include 07_get-metric.R
#' @include 08_str-collapse.R
#'
#' @examples
#' # Load data
#' data(mtcars)
#'
#' # Example 1: Using single variable regression with lm method
#' train_df <- target_df(mtcars[1:16, ], 'gear', "am", "vs")
#' test_df <- target_df(mtcars[17:32, ], 'gear', "am", "vs")
#' create_metric_df(train_df, test_df, metric = "rmse", method = "lm", target_variable = "gear", predictors_vector = "am")
#'
#' # Example 2: Using k-nearest neighbor method with optimal k
#' create_metric_df(train_df, test_df, metric = "mae", method = "kknn", kmin = 3, target_variable = "gear", predictors_vector = c("am", "vs"))

create_metric_df <- function(train_df, test_df, metric, method, kmin="NA", target_variable, predictors_vector){

  # Check if all variables are of correct class
  check_class <- function(x, cls) {
    if (!all(sapply(x, function(y) class(y) %in% cls))) {
      stop(paste("At least one", cls, "is of the wrong class."))
    }
    invisible(NULL)
  }

  check_class(list(train_df, test_df), "data.frame")
  check_class(list(metric, method, target_variable), "character")
  check_class(predictors_vector, "character")

  if (!(metric %in% c("rmse", "rsq", "mae"))){
    stop("Please input a valid metric")
  }

  if (!(target_variable %in% colnames(train_df))){
    stop("target_variable not found in prediction_model!")
  }

  if (!(method %in% c("lm", "kknn"))){
    stop("Invalid method specified")
  }

  #create train data, includes win rate and predictors
  target_train_df <- target_df(df=train_df, target_variable, predictors_vector)

  #create test data, includes win rate and predictors
  target_test_df <- target_df(df=test_df, target_variable, predictors_vector)

  #create model recipe
  model_recipe <- create_recipe(target_df=target_train_df, target_variable=target_variable)

  #apply create_spec_kmin function and obtain model specification and kmin (if applicable)
  model_spec_kmin_list <- create_spec_kmin(df=target_train_df, model_recipe=model_recipe,
                                           method=method, kmin=kmin, metric=metric,
                                           target_variable=target_variable)

  #extract model spec
  model_spec <- get_list_item(model_spec_kmin_list, n=1)

  #extract kmin
  model_kmin <- get_list_item(model_spec_kmin_list, n=2)

  #create model fit
  model_fit <- create_fit(model_recipe, model_spec, target_train_df)

  #create prediction model
  model_pred <- create_model_prediction(target_test_df, model_fit)

  #extract metric result
  metric_result <- get_metric(prediction_model=model_pred, metric, target_variable)

  #format predictors string
  if (length(predictors_vector) > 1){ #if there is more than 1 predictor i.e, multi-variable regression
    predictors_vector <- str_collapse(predictors_vector) #combine input arguments into a string
  }
  #print("metric df successful")
  return (
    data.frame(
      outcome=target_variable,
      predictor=predictors_vector,
      metric=metric,
      metric_value=metric_result,
      method=method,
      kmin=model_kmin
    )
  )
}
