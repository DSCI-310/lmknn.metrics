#' Bind metric result data frames using rbindlist function
#'
#' This function binds together data frames created from the \code{create_metric_df()} function using the \code{rbindlist()} function from the \code{data.table} package. The data frames are created by fitting linear models to the training data using the predictor variables provided in \code{model_list}, and then calculating the specified metric on the test data.
#'
#' @param train_df A data frame containing the training data
#' @param test_df A data frame containing the test data
#' @param metric A character string indicating the metric to be calculated. Possible values are "rmse", "mae", "r2"
#' @param method A character string indicating the type of model to be fitted. Possible values are "lm" (for linear regression) and "glm" (for generalized linear models).
#' @param kmin An integer indicating the minimum value of k for k-fold cross-validation. If set to "NA", no cross-validation is performed.
#' @param target_variable A character string indicating the name of the target variable.
#' @param model_list A list containing the names of the predictor variables to be used in the linear models.
#'
#' @return A data frame containing the metric results for each predictor variable.
#' @export
#'
#' @include 09_create-metric-df.R
#'
#' @examples
#' # load data
#' data(mtcars)
#'
#' train_df <- mtcars[1:16, ]
#' test_df <- mtcars[17:32, ]
#'
#' single_predictors <- list("mpg", "cyl", "disp", "hp", "am")
#' multiple_predictors <- list(c("mpg", "cyl"), c("disp", "am"), c("cyl", "am") )
#'
#' # Single predictor lm regression model
#' metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="lm", kmin="NA", target_variable='gear', model_list=single_predictors)
#'
#' # Single predictor kknn regression model
#' metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="kknn", kmin=4, target_variable='gear', model_list=single_predictors)

#' # Multiple predictors lm regression model
#' metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="lm", kmin="NA", target_variable='gear', model_list=multiple_predictors)
#'
#' # Multiple predictors kknn regression model
#' metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="kknn", kmin=8, target_variable='gear', model_list=multiple_predictors)
#'
#' @importFrom data.table rbindlist

metric_bind <- function(train_df, test_df, metric, method, kmin="NA", target_variable, model_list){

  # Check if all variables are of correct class
  check_class <- function(x, cls) {
    if (!all(sapply(x, function(y) class(y) %in% cls))) {
      stop(paste("At least one", cls, "is of the wrong class."))
    }
    invisible(NULL)
  }

  check_class(list(train_df, test_df), "data.frame")
  check_class(list(metric, method, target_variable), "character")

  if (!(inherits(model_list, "list"))){
    stop("model_list must be a list!")
  }
  if (!(metric %in% c("rmse", "rsq", "mae"))){
    stop("Please input a valid metric")
  }

  if (!(target_variable %in% colnames(train_df))){
    stop("target_variable not found in prediction_model!")
  }

  if (!(method %in% c("lm", "kknn"))){
    stop("Invalid method specified")
  }

  metric_result_df <- data.table::data.table()
  # Iterate over the models in the list and create a data.frame for each model
  for (i in seq_along(model_list)){
    # Call create_metric_df() function with correct arguments
    metric_result <- create_metric_df(train_df, test_df, metric, method, kmin, target_variable, model_list[[i]])
    # Bind the new metric result to the metric_result_df
    metric_result_df <- data.table::rbindlist(list(metric_result_df, metric_result))
  }
  return(metric_result_df)
}
