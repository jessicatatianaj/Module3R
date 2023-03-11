library(tidyverse)
library(tm)
library(ggplot2)
library(janitor)
library(lubridate)
library(rtweet)
library(ggrepel)
library(tidytext)
library(stopwords)
library(wordcloud)

library(dplyr)
#install.packages("rtweet", repos = 'https://ropensci.r-universe.dev/')

library("rtweet")
auth_setup_default()
rt <- search_tweets(q = "Geothermal Energy", n = 500, include_rts = FALSE, lang = "en")
raw_tweets1 <- search_tweets(q = "\"Geothermal energy\"", n = 500, include_rts = FALSE, lang = "en")
raw_tweets2 <- search_tweets(q = "\"Geothermal heating\"", n = 500, include_rts = FALSE, lang = "en")
raw_tweets3 <- search_tweets(q = "\"Geothermal cooling\"", n = 500, include_rts = FALSE, lang = "en")
raw_tweets=rbind(raw_tweets1,raw_tweets2,raw_tweets3)
raw_tweets %>% head(5)
raw_tweets %>% 
  glimpse()
variables_for_analysis <- c("created_at","id","full_text")
working_tweets <- raw_tweets %>% 
  select(all_of(variables_for_analysis))
working_tweets <- working_tweets %>% 
  mutate(created_at = as.Date(created_at)) %>% 
  filter(!is.na(created_at))
a_hot_day <- 5
hot_days <- working_tweets %>% 
  tabyl(created_at) %>% 
  filter(n > a_hot_day)
working_tweets %>% 
  tabyl(created_at) %>% 
  arrange(desc(n)) %>% 
  head(5)
