
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lmkknn.metrics

<!-- badges: start -->
<!-- badges: end -->

The goal of lmkknn.metrics is to …

## Installation

You can install the development version of lmkknn.metrics from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("DSCI-310/dsci-310-group-16-pkg.")
```

## Example Use Cases:

This is a basic example which shows you how to solve a common problem:

``` r
library(lmkknn.metrics)
## basic example code
```

## Here are some examples of use cases for the functions provided in lmkknn.metrics:

target_df: Selecting the target variable and additional columns from a
dataframe.

    library(lmkknn.metrics)

    # Selecting only the target variable
    target_df(mtcars, "mpg")

    # Selecting the target variable and additional columns
    target_df(mtcars, "mpg", cyl, disp)

create_recipe: Creating a recipe object for modeling based on the
specified target variable and predictors.

    # Load data
    data("mtcars")

    # Select target variable and predictors
    target_df <- target_df(mtcars, "gear", mpg, cyl, disp)

    # Create recipe object for modeling
    recipe <- create_recipe(target_df, "gear")

get_list_item: Retrieving the nth element of a given list.

    # Create a list
    my_list <- list(a = 1, b = 2, c = 3)

    # Retrieve second element from list
    get_list_item(my_list, 2)

create_model_prediction: Creating a prediction model using a trained
model fit and a test dataset.

    # Load data
    data("mtcars")

    # Split data into training and testing datasets
    train_df <- target_df(mtcars[1:16, ], 'gear', c("am", "vs"))
    test_df <- target_df(mtcars[17:32, ], 'gear', c("am", "vs"))

    # Create recipe object for modeling
    x_recipe <- create_recipe(train_df, target_variable="gear")

    # Create specification for k-nn model
    x_spec_list <- create_spec_kmin(train_df, model_recipe=x_recipe, method="lm", target_variable="gear")
    x_spec <- get_list_item(x_spec_list, n=1)

    # Fit the model to training data
    x_fit <- create_fit(x_recipe, x_spec, train_df)

    # Generate predictions for testing data
    create_model_prediction(test_df, x_fit )

str_collapse: Collapsing a string of arguments and joining them by ‘+’.

    str_collapse("my name")
    str_collapse(c("my name", "is", "jake"))
    str_collapse(c("my name", "is", 2))
    str_collapse(c(3, 2, "boy"))

## Functions:

The package provides the following functions:

target_df(): Selects the target variable and additional columns from a
dataframe. create_recipe(): Creates a recipe object for modeling based
on the specified target variable and predictors. get_list_item():
Retrieves the nth element of a given list. create_model_prediction():
Creates a prediction model using a trained model fit and a test dataset.
str_collapse(): Collapses a string of arguments and joins them by ‘+’.

For more information on how to use each function, see the package
documentation.

## Contributing

We appreciate contributions to the lmkknn.metrics package. Please refer
to our Contributing document and Code of Conduct for more information.

## License

The software provided in this project is offered under the MIT open
source license. Refer to the license file for more information.

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.

You can also embed plots, for example:

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
