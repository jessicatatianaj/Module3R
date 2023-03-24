install.packages("hcandersenr") 
install.packages("tidyverse") 
install.packages("tidytext") 
install.packages("stringr") 
install.packages("tibble") 
install.packages("ggplot2") 
install.packages(c('tibble', 'dplyr', 'readr'))

library(hcandersenr)
library(tidyverse)
library(tidytext)
library(stringr)
library(dplyr)
library(tibble)
library(ggplot2)

file_str <- paste(readLines("~/Documents/R_Projects/Module3R/scrapedTweets.txt"), collapse="\n")

lexicon_stakeholders <- c("government", "geothermal companies", "concerned groups", "investors", "researchers", "media platform", "consumers", "tourist")

stakeholder_tweets_tibble <- tibble(stakeholder = lexicon_stakeholders)

# add empty column to existing tibble
stakeholder_tweets_tibble['count'] <- NA

for (pattern in lexicon_stakeholders) {
  print(pattern)
  countResult <- sum(str_count(file_str, pattern))
  print(countResult)
  stakeholder_tweets_tibble$count[stakeholder_tweets_tibble$stakeholder == pattern] <- countResult
}

ggplot(stakeholder_tweets_tibble, aes(x = stakeholder, y = count)) +
  geom_bar(stat = "identity")





