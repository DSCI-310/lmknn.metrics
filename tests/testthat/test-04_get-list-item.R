# Load function
get_list_item <- function(list_object, n){
  if (!is.numeric(n) | n < 1){
    stop("n has to be an integer > 0!")
  }
  return(list_object[[n]])
}

# Test case 1: Test valid input parameters
test_that("get_list_item() with valid arguments", {
  list_object <- list("player_id", "height", "age")
  n <- 2

  expect_equal(get_list_item(list_object, n), c("height"))
})


# Test case 2: Test n less than 1
test_that("get_list_item() with negative numeric call", {
  list_object <- list("player_id", "height", "age")
  n <- -1
  expected_error <- "n has to be an integer > 0"

  expect_error(get_list_item(list_object, n), c(expected_error))
})

# Test case 3: Test non-numeric n
test_that("get_list_item() with string numeric call", {
  list_object <- list("player_id", "height", "age")
  n <- "two"
  expected_error <- "n has to be an integer > 0!"

  expect_error(get_list_item(list_object, n), c(expected_error))
})