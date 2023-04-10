library(testthat)
library(dplyr)

train_df <- lmkknn.metrics::target_df(mtcars[1:16, ], 'gear', "am")
test_df <- lmkknn.metrics::target_df(mtcars[17:32, ], 'gear', "am")
metric_df <- lmkknn.metrics::create_metric_df(train_df, test_df, metric = "rmse", method = "lm", target_variable = "gear", predictors_vector = "am")

# test that create_metric_df returns an error upon invalid inputs
test_that("get_metric throws error if invalid input", {
  #invalid metric
  expect_error(lmkknn.metrics::create_metric_df(train_df, test_df, metric = "lol", method = "lm", target_variable = "gear", predictors_vector = "am"),
               "Please input a valid metric")
  #invalid method
  expect_error(lmkknn.metrics::create_metric_df(train_df, test_df, metric = "rmse", method = "rf", target_variable = "gear", predictors_vector = "am"),
               "Invalid method specified")
  #invalid target variable
  expect_error(lmkknn.metrics::create_metric_df(train_df, test_df, metric = "rmse", method = "lm", target_variable = "looooll", predictors_vector = "am"),
               "target_variable not found in prediction_model!")
  #train_df not of class data.frame
  expect_error(lmkknn.metrics::create_metric_df(2, test_df, metric = "rmse", method = "lm", target_variable = "gear", predictors_vector = "am"),
               "At least one data.frame is of the wrong class.")
  #test_df not of class data.frame
  expect_error(lmkknn.metrics::create_metric_df(train_df, 2, metric = "rmse", method = "lm", target_variable = "gear", predictors_vector = "am"),
               "At least one data.frame is of the wrong class.")
})

#test that create-metric-df returns data.frame object
test_that("create-metric-df returns data.frame object", {
  expect_s3_class(metric_df, "data.frame")
})

#test that kmin column is created
test_that("create-metric-df returns data.frame object with `outcome`, `predictor`, `metric`, `metric_value`, `method, `kmin` columns", {
  expect_equal(colnames(metric_df), c("outcome", "predictor", "metric", "metric_value", "method", "kmin"))
})

#test that kmin column returns "NA" when using lm regression
test_that("create-metric-df returns NA kmin for lm regression model", {
  kmin <- metric_df %>% select(kmin) %>% pull()
  expect_equal(kmin, "NA")
})

#test that kmin column returns kmin value which was specified
test_that("create-metric-df returns NA kmin for lm regression model", {
  kmin_specified <- 4
  kmin_model <- lmkknn.metrics::create_metric_df(train_df, test_df, metric = "rmse", method = "kknn", kmin=kmin_specified, target_variable = "gear", predictors_vector = "am")
  kmin <- kmin_model %>% select(kmin) %>% pull()
  expect_equal(kmin, kmin_specified)
})
