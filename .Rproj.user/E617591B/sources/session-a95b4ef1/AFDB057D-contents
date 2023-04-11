library(lmkknn.metrics)
library(testthat)

# Create some sample data
data(mtcars)
target_df <- lmkknn.metrics::target_df(mtcars, "mpg", "cyl", "disp", "hp")

# Create model recipe
model_recipe <- lmkknn.metrics::create_recipe(target_df, "mpg")

# Create model specification
model_spec_lm_list <- lmkknn.metrics::create_spec_kmin(target_df, model_recipe, "lm", target_variable="mpg")
model_spec_kknn_list <- lmkknn.metrics::create_spec_kmin(target_df, model_recipe, "kknn", kmin=5, target_variable="mpg")

# Create some test cases
test_that("create_fit returns a valid model fit", {
  #create model recipe for lm
  model_spec_lm <- lmkknn.metrics::get_list_item(model_spec_lm_list, 1)
  # Test that create_fit returns a valid model fit object
  model_fit_lm <- lmkknn.metrics::create_fit(model_recipe,
                                             model_spec_lm,
                                             target_df)

  expect_equal(class(model_fit_lm), "workflow")

  #create model recipe for kknn
  model_spec_kknn <- lmkknn.metrics::get_list_item(model_spec_kknn_list, 1)
  model_fit_kknn <- lmkknn.metrics::create_fit(model_recipe,
                                               model_spec_kknn,
                                               target_df)
  expect_equal(class(model_fit_kknn), "workflow")
})

test_that("create_fit raises an error when the input is invalid", {
  # Test that create_fit raises an error when the input is invalid
  expect_error(lmkknn.metrics::create_fit(model_recipe, NULL, target_df), "model_spec has to be either linear reg or nearest_neighbor method")
  expect_error(lmkknn.metrics::create_fit(NULL, get_list_item(model_spec_lm_list, 1), target_df), "model_recipe must be of class recipe")
  expect_error(lmkknn.metrics::create_fit(model_recipe, get_list_item(model_spec_lm_list, 1), NULL), "df must be a dataframe!")
})
