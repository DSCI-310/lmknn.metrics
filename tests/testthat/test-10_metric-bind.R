library(testthat)
library(data.table)


# load data
data(mtcars)

train_df <- mtcars[1:16, ] #create train df
test_df <- mtcars[17:32, ] #create test df

single_predictors <- list("mpg", "cyl", "disp", "hp", "am") #single predictors list
multiple_predictors <- list(c("mpg", "cyl"), c("disp", "am"), c("cyl", "am") )

# test that create_metric_df returns an error upon invalid inputs
test_that("get_metric throws error if invalid input", {
  #invalid metric
  expect_error(lmkknn.metrics::metric_bind(train_df=train_df, test_df=test_df, metric="loool", method="lm", kmin="NA", target_variable='gear', model_list=single_predictors),
               "Please input a valid metric")
  #invalid method
  expect_error(lmkknn.metrics::metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="rf", kmin="NA", target_variable='gear', model_list=single_predictors),
               "Invalid method specified")
  #invalid target variable
  expect_error(lmkknn.metrics::metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="lm", kmin="NA", target_variable='ball', model_list=single_predictors),
               "target_variable not found in prediction_model!")
  #train_df not of class data.frame
  expect_error(lmkknn.metrics::metric_bind(train_df=c(2, 2, 2), test_df=test_df, metric="rmse", method="lm", kmin="NA", target_variable='gear', model_list=single_predictors),
               "At least one data.frame is of the wrong class.")
  #test_df not of class data.frame
  expect_error(lmkknn.metrics::metric_bind(train_df=train_df, test_df=c(2, 2, 2), metric="rmse", method="lm", kmin="NA", target_variable='gear', model_list=single_predictors),
               "At least one data.frame is of the wrong class.")
  #model list is not a list
    expect_error(lmkknn.metrics::metric_bind(train_df=train_df, test_df=test_df, metric="rmse", method="lm", kmin="NA", target_variable='gear', model_list=c(2, 2, 2)),
               "model_list must be a list!")
})
