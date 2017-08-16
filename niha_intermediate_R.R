#'These are totes some go-to R packages
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(ggplot2)
library(janitor)
library(knitr)
library(readr)
library(tm)

#'Read in csv.
#'since this file is on the larger side, we are going to use the 'read_csv' from the package read_r.
#' Notice how there are extra columns and the column names are not consistently formatted. 
#'Let's clean up the column names using a nifty package called janitor
#'if we don't use janitor we could also rename them another way

df <- read_csv("/Users/Niha/Desktop/just_tacos_and_burritos.csv") %>% clean_names()


#'Sometimes when reading in .csv files, we get random empty columns and rows. There are several ways to get only the rows/columns we are interested in keeping. Let's try using subsetting to filter out clutter
#'
#'janitor has the ability to do this too...

#'We are going start by using colSums
df <- df[,colSums(is.na(df)) < nrow(df)] 

#' This is a common problem that we can encounter in a lot of data sets.
#' this tells R to sum the number of rows with NA's, and if that sum is less than the total number of rows, keep those columns. Since there are 77,260 rows in this data frame.

#' How many unique restaurants are being described in this dataset?
#+ 
#' 'group_by' in dplyr offers us a useful way to group all the spread out restaurant info
#' what information would be useful to summarise per group.
#' How about, how many menu items does each restaurant have? Which has the most?
df %>% group_by(name) %>% summarise(menu_items = length(menus_name)) %>% top_n(10)

#' notice that there are two versions of McDonalids, and Sonic Drive In. 
#' Different capitalizations. Also I think we've all been to fast-food joints like these and there's no way they can have so many menu items. There are bound to be duplicates. 
#' 
#' deduped
df %>% group_by(name)%>% distinct(menus_name) %>% summarise(menu_items = length(menus_name))

#'standardize fast food joint names

#'common ingredients featured in menu item descriptions
#'build a word cloud maybe with menu items, first we'll need a document term matrix?D
#'should we handle this the 'tidy text' way or use document term matrices?
corpus <- Corpus(VectorSource(df$menus_description))
corpus <- corpus %>% tm_map(.,tolower) %>% tm_map(., removePunctuation) %>%
              tm_map(., removeNumbers) %>% tm_map(., removeWords,stopwords("english"))

TDM <- TermDocumentMatrix(corpus)

findFreqTerms(TDM, 5000)
findAssocs(TDM, "mexican", 0.3)

#'It would be cool if we could visualize all the restaurant locations in the U.S. 
#'However notice there are a lot of missing lats/longitutdes... How should we clean address names?






#' Menu names have a lot of potential for cleaning. Notice the '()' in a lot of the menu items.

#' What are some interesting questions we can ask from this dataset? 
