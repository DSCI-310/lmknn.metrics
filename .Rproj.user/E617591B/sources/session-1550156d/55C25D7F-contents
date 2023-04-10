library(testthat)
library(dplyr)
library(yardstick)

#create train df
train_df <- lmkknn.metrics::target_df(mtcars[1:16, ], 'gear', c("am", "vs"))

#create test df
test_df <- lmkknn.metrics::target_df(mtcars[17:32, ], 'gear', c("am", "vs"))

#create model recipe
x_recipe <- lmkknn.metrics::create_recipe(train_df, target_variable="gear")

#generate new model recipe with kmin
x_spec_list <- lmkknn.metrics::create_spec_kmin(train_df, model_recipe=x_recipe, method="lm", target_variable="gear")

#extract model specifications
x_spec <- lmkknn.metrics::get_list_item(x_spec_list, n=1)

#create model fit
x_fit <- lmkknn.metrics::create_fit(x_recipe, x_spec, train_df)

#create model prediction
x_pred <- lmkknn.metrics::create_model_prediction(test_df, x_fit )

#get model metric value
x_metric <- get_metric(x_pred, "rmse", "gear")

# test that function throws error if target_test_df is not a data frame
test_that("get_metric throws error if invalid input", {
  expect_error(lmkknn.metrics::get_metric(NULL,"rmse", "gear"), "prediction_model must be a dataframe!")
  expect_error(lmkknn.metrics::get_metric(x_pred, "lol", "gear"), "Please input a valid metric")
  expect_error(lmkknn.metrics::get_metric(x_pred,"rmse", "lol"), "target_variable not found in prediction_model!")
})

# test that function returns an integer
test_that("get_metric returns a metric which is of class numeric", {
  expect_equal(inherits(x_metric, "numeric"), TRUE)
})
