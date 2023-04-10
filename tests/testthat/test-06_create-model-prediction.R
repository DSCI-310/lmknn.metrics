library(testthat)
library(dplyr)
library(stats)

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

# test that function throws error if target_test_df is not a data frame
test_that("create_model_prediction throws error if invalid input", {
  expect_error(lmkknn.metrics::create_model_prediction(test_df, NULL), "model fit must be of workflow class!")
  expect_error(lmkknn.metrics::create_model_prediction(NULL, x_fit), "target_test_df must be a dataframe!")
})

# test that function returns a data frame
test_that("create_model_prediction returns a data frame", {
  expect_s3_class(x_pred, "data.frame")
})

# test that only one prediction column has been appended
test_that("only one prediction column has been appended", {
  expect_equal(ncol(x_pred)-1, ncol(test_df))
})
