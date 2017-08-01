#'These are totes some go-to R packages
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(ggplot2)
library(devtools)
library(roxygen2)
library(janitor)
library(knitr)

#'Read in csv. Notice how there are extra columns and the column names are not consistently formatted. 
#'Let's clean up the column names using a nifty package called janitor
#'if we don't use janitor we could also rename them another way
df <- read.csv("/Users/Niha/Desktop/just_tacos_and_burritos.csv", stringsAsFactors = FALSE, na.strings=c("","NA")) %>% clean_names() %>% select(id : websites)


#'Right off the bat I see lots of duplicates in this dataset. Lets try deduping this thing.
df <- df %>% distinct()

#' Hmm... the dataframe doesn't seem to have changed. Let's look at little more carefully at the dataset.
#' It looks like the rows have only some duplicated information, or some have more data than others in specific columns How should we deal with this?
#' For consistency let's replace all the empty string valued indices with NAs. We could do this several ways. The easiest way is to modify our previous "read.csv" function "na.strings=c("","NA")"


#' Notice how each of the restaurants listed has a unique ID. 
#' How many unique restaurants are being described in this dataset?
#+ 
length(unique(df$id))
#' What are some interesting questions we can ask from this dataset? 

##need to do something with categories
##restrict to tX