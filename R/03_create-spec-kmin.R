#' @title Create model specification with optional kmin tuning
#'
#' @description This function creates a model specification for either linear regression or k-nearest neighbor regression, with an optional kmin tuning for the latter. If kmin is not specified, the function performs a grid search to find the optimal k value that gives the minimum root mean squared error (RMSE) on a 5-fold cross-validation of the training data.
#'
#'
#' @param df A data frame containing the training data.
#' @param model_recipe A recipe object created using the `create_recipe` function.
#' @param method A character string indicating the type of regression method to be used: "lm" for linear regression or "kknn" for k-nearest neighbor regression.
#' @param metric A character string specifying the performance metric to calculate ("rmse", "rsq", or "mae")
#' @param kmin A numeric value specifying the minimum number of neighbors to be considered when performing k-nearest neighbor regression. If set to "NA", the function performs a grid search to find the optimal k value. Default is "NA".
#' @param target_variable A character string indicating the name of the target variable to be predicted.
#' @param weight_func A character string indicating the weight function used for the k-nearest neighbor regression. Default is "rectangular".
#' @param mode A character string indicating the type of regression task. Default is "regression".

#' @return A list containing the model specification and the kmin value (if applicable).
#' @export
#'
#' @include 02_create-recipe.R
#'
#' @examples
#' train_df <- mtcars[1:16, ]
#' target_df <- target_df(train_df, "gear")
#' model_recipe <- create_recipe(target_df, "gear")
#' create_spec_kmin(train_df, model_recipe, "lm", metric="rmse", target_variable="gear")
#' create_spec_kmin(train_df, model_recipe, "kknn", metric="rmse", kmin=5, target_variable="gear")
#'
#' @import dplyr
#' @importFrom recipes recipe update_role step_scale step_center all_predictors
#' @importFrom parsnip nearest_neighbor set_engine set_mode linear_reg
#' @importFrom workflows workflow add_recipe add_model
#' @importFrom tune tune_grid collect_metrics
#' @importFrom tibble tibble
#' @importFrom rsample vfold_cv
#'

#'
create_spec_kmin <- function(df, model_recipe, method, kmin='NA', metric, target_variable, weight_func="rectangular", mode="regression"){
  if (method=="kknn"){ #if kknn regression is used
    if (kmin=='NA'){
      #tune model spec to find optimal kmin when kmin not specified
      model_spec <- parsnip::nearest_neighbor(weight_func=weight_func, neighbors=tune()) %>%
        parsnip::set_engine(method) %>% #whether KNN or Linear Regression
        parsnip::set_mode(mode)

      model_workflow <- workflows::workflow() %>%
        workflows::add_recipe(model_recipe) %>%
        workflows::add_model(model_spec)

      model_vfold <- rsample::vfold_cv(df, v=5, strata=target_variable)

      gridvals <- tibble(neighbors=seq(1,40))

      model_results <- model_workflow %>%
        tune::tune_grid(resamples=model_vfold, grid=gridvals) %>%
        tune::collect_metrics() %>%
        dplyr::filter(.metric==metric) %>%
        dplyr::filter(mean==min(mean))

      kmin <- dplyr::pull(model_results, neighbors) #derive k value that gives minimum rmspe value

    } else if (!is.numeric(kmin)) { #check if kmin specified is numeric
      stop("invalid kmin specified")
    }
    #create tennis model specification if kmin is specified
    model_spec <- parsnip::nearest_neighbor(weight_func=weight_func, neighbors=kmin) %>%
      parsnip::set_engine(method) %>%
      parsnip::set_mode(mode)

  } else if (method=="lm"){ #if linear regression is used
    model_spec <- parsnip::linear_reg() %>%
      parsnip::set_engine(method) %>%
      parsnip::set_mode(mode)

  } else {
    stop("Invalid method specified")
  }
  #print("model spec produced!")
  return(list(model_spec, kmin))
}
