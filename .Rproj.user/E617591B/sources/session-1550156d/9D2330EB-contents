library(testthat)
library(recipes)
library(dplyr)

# create test data frame
df <- data.frame(a = c(1,2,3), b = c("a", "b", "c"), c = c(TRUE, FALSE, TRUE), target = c(0, 1, 0))

# test the function returns a recipe object
test_that("create_recipe returns a recipe object", {
  recipe <- lmkknn.metrics::create_recipe(df, "target")
  expect_s3_class(recipe, "recipe")
})

# test the function includes all predictors
test_that("create_recipe includes all predictors", {
  recipe <- lmkknn.metrics::create_recipe(df, "target")
  expect_equal(length(recipe$var_info)-1, 3)
})

# test the function updates target variable's role
test_that("create_recipe updates the target variable's role", {
  recipe <- lmkknn.metrics::create_recipe(df, "target")
  target_role <- recipe$var_info %>%
    dplyr::filter(variable=="target") %>%
    select(role) %>%
    pull()
  expect_equal(target_role, "outcome")
})
