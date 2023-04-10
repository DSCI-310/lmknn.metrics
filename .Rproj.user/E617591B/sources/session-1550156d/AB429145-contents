library(testthat)

# create some example data for testing
set.seed(123)
train_df <- mtcars[1:16, ]
target_df <- lmkknn.metrics::target_df(train_df, "gear")
model_recipe <- lmkknn.metrics::create_recipe(target_df, "gear")

# Test case 1: Test that the function returns a list containing a model specification and kmin value when kmin is not specified
test_that("create_spec_kmin returns a list with model specification and kmin value when kmin is not specified and method is lm", {
  output <- lmkknn.metrics::create_spec_kmin(train_df, model_recipe, method="lm", metric="rmse", target_variable="gear")
  expect_true(is.list(output))
  classes <- strsplit(class(output[[1]]), " ")
  expect_true(all(c("linear_reg", "model_spec") %in% classes))
  kmin <- output[[2]]
  expect_equal(kmin, "NA")
})

# Test case 2: Test that the function returns a list containing a model specification and kmin value when kmin is specified
test_that("create_spec_kmin returns a list with model specification and kmin value when kmin is specified", {
  output <- lmkknn.metrics::create_spec_kmin(train_df, model_recipe, method="kknn", metric="rmse", kmin=5, target_variable="gear")
  expect_true(is.list(output))
  classes <- strsplit(class(output[[1]]), " ")
  expect_true(all(c("model_spec", "nearest_neighbor") %in% classes))
  kmin <- output[[2]]
  expect_equal(kmin, 5)
})

# Test case 3: Test that the function raises an error when an invalid method is specified
test_that("create_spec_kmin raises an error when an invalid method is specified", {
  expect_error(lmkknn.metrics::create_spec_kmin(train_df, model_recipe, method="invalid_method", metric="rmse", target_variable="gear"))
})

# Test case 4: Test that the function raises an error when kmin is not numeric.
test_that("create_spec_kmin raises an error when kmin is not numeric", {
  expect_error(lmkknn.metrics::create_spec_kmin(train_df, model_recipe, method="kknn", metric="rmse", kmin="invalid_kmin", target_variable="gear"))
})
