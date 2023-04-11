library(testthat)

# Test for valid input
test_that("str_collapse returns a string with input parameters separated by '+'", {
  expect_equal(str_collapse(c("my name", "is", "jake")), "my name + is + jake")
})

# Test for invalid input
test_that("str_collapse throws an error for invalid additional input", {
  expect_error(str_collapse(c("my name", "is", 2), "me"))
})
