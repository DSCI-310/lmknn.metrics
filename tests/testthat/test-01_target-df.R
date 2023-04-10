library(testthat)
library(dplyr)

# create test data frame
df <- data.frame(a = c(1,2,3), b = c("a", "b", "c"), c = c(20, 30, 40))

# test the function with only target_variable
test_that("target_df returns a data frame with only the target variable", {
  output_df <- lmkknn.metrics::target_df(df, "a")
  expect_equal(ncol(output_df), 1)
  expect_equal(colnames(output_df), "a")
})

# test the function with target_variable and additional columns
test_that("target_df returns a data frame with only the target variable and additional columns", {
  output_df <- lmkknn.metrics::target_df(df, "a", "b")
  expect_equal(ncol(output_df), 2)
  expect_equal(colnames(output_df), c("a", "b"))
})
