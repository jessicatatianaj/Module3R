# Load required packages
install.packages("ggplot2") 
install.packages("tm") 
install.packages("janitor") 
install.packages("wordcloud") 
install.packages("lubridate") 
install.packages("rtweet") 
install.packages("ggrepel") 
install.packages("tidytext") 
install.packages("stopwords") 
install.packages("reshape2") 
install.packages("syuzhet") 
install.packages("gghighlight")
install.packages("tidytext")

library(tidytext)
library(tidyverse)
library(tm)
library(ggplot2)
library(janitor)
library(wordcloud)
library(lubridate)
library(rtweet)
library(ggrepel)
library(tidytext)
library(stopwords)
library(reshape2)
library(syuzhet)
library(gghighlight)


tidy_articles <- working_columns %>% unnest_tokens(word, Article) 

tidy_articles_no_stop_words <- working_columns %>% unnest_tokens(word, Article) %>% anti_join(stop_words)

sentiments <- get_sentiment_dictionary('nrc', 'english')
# Join sentiments and cleaned tweets
sentiment_article_word <- tidy_articles_no_stop_words  %>%
  inner_join(sentiments)


mySentiment <- unique(sentiments$sentiment)
print(mySentiment)

sentiment_tibble <- tibble(mySentiment, count = 0)

for (pattern in mySentiment) {
  print(pattern)
  countResult <- sum(str_count(sentiment_article_word$mySentiment, pattern))
  print(countResult)
  #sentiment_tibble$count[sentiment_tibble$mySentiment== pattern] <- countResult
}




