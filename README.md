
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

`target_df`: Selecting the target variable and additional columns from a
dataframe.

    library(lmkknn.metrics)

    # Selecting only the target variable
    target_df(mtcars, "mpg")

    # Selecting the target variable and additional columns
    target_df(mtcars, "mpg", cyl, disp)

`create_recipe`: Creating a recipe object for modeling based on the
specified target variable and predictors.

    # Load data
    data("mtcars")

    # Select target variable and predictors
    target_df <- target_df(mtcars, "gear", mpg, cyl, disp)

    # Create recipe object for modeling
    recipe <- create_recipe(target_df, "gear")

`get_list_item`: Retrieving the nth element of a given list.

    # Create a list
    my_list <- list(a = 1, b = 2, c = 3)

    # Retrieve second element from list
    get_list_item(my_list, 2)

`create_model_prediction`: Creating a prediction model using a trained
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

`str_collapse`: Collapsing a string of arguments and joining them by
‘+’.

    str_collapse("my name")
    str_collapse(c("my name", "is", "jake"))
    str_collapse(c("my name", "is", 2))
    str_collapse(c(3, 2, "boy"))

## Functions:

The package provides the following functions:

`target_df()`: Selects the target variable and additional columns from a
dataframe.

`create_recipe()`: Creates a recipe object for modeling based on the
specified target variable and predictors.

`create_spec_kmin()`: This function creates a model specification for
either linear regression or k-nearest neighbor regression, with an
optional kmin tuning for the latter. If kmin is not specified, the
function performs a grid search to find the optimal k value that gives
the minimum root mean squared error (RMSE) on a 5-fold cross-validation
of the training data.

`get_list_item()`: Retrieves the nth element of a given list.

`create_fit()`: Creates a fitted model using a model recipe based on
predictors and target variable, model specification, and dataframe.

`create_model_prediction()`: Creates a prediction model using a trained
model fit and a test dataset.

`get_metric()`: Extracts a specified metric from a prediction model.

`str_collapse()`: Collapses a string of arguments and joins them by ‘+’.

`create_metric_df()`: This function takes as input two data frames:
train_df and test_df that contain the training and test data for a
prediction model, respectively. It also takes a character string
specifying the performance metric to calculate “metric”, a character
string specifying the prediction model to use “method”, an integer
specifying the minimum number of neighbors to consider when using the
“kknn” method “kmin”, a character string specifying the name of the
target variable in the data frames target_variable, and a character
vector specifying the names of the predictor variables in the data
frames “predictors_vector”. The function returns a data frame containing
the specified performance metric, the predictor variables, the
prediction model method, and the value of kmin “if applicable”.

`metric_bind()`: This function binds together data frames created from
the function using the function from the package. The data frames are
created by fitting linear models to the training data using the
predictor variables provided in , and then calculating the specified
metric on the test data.

For more information on how to use each function, see the package
documentation.

## Contributing

We appreciate contributions to the lmkknn.metrics package. Please refer
to our Contributing document and Code of Conduct for more information.

## License

The software provided in this project is offered under the MIT open
source license. Refer to the license file for more information.
