library('dplyr')
library('purrr')

#' Reading in the data and assigning the data to a variable.
#' 
#' By storing the data in a variable and only accessing the data using the variable,
#' we can avoid needing to load the data again as we work on our data.
just_tacos_data <- read.csv('just_tacos_and_burritos.csv')

#' Let's learn a little bit about our data.
just_tacos_data %>%
  nrow()

just_tacos_data %>%
  ncol()

just_tacos_data %>%
  dim()

#' Something looks off about the dimensions, especially the number of columns.
#' 
#' Taking a look at the first few rows, we notice that the last several columns are empty.
just_tacos_data %>%
  head()

just_tacos_column_names <- just_tacos_data %>%
                  names()

#' Looking at data by column or row, maybe?


#' need a way to mention/segway/introduce the idear of data types
just_tacos_data %>%
  class()

#' Knnowing what type something is helps us know what functions
#' we can run on the data.

nonempty_column_names <- just_tacos_column_names[seq(1, 26)]
nonempty_tacos_data <- just_tacos_data[nonempty_column_names]


#' Check to see that empty columns are gone.
nonempty_tacos_data %>%
  head()


#' Looks great, but it would also be nice to be able to more generically
#' remove empty columns.
#' 
#' To do this we need to:
#' 
#'   * Look at each column
#'   * Check each item in each column for `is.na`
#'   * If any item in column `is.na` is `FALSE`
#'     * Add to valid column names
#'     * Continue to next column

data_to_clean <- just_tacos_data

column_names <- data_to_clean %>%
  names()
keep_column_indices <- c()

column_index <- 1
for(column in data_to_clean) {
  for(item in column) {
    if (!is.na(item)) {
      keep_column_indices <- append(keep_column_indices, column_index)
      break
    }
  }
  column_index <- column_index + 1
}
data_cleaned <- data_to_clean[keep_column_indices]


