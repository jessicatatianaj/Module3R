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

read_csv = read.csv("~/Documents/R_Projects/Module3R/data/articles/AllNews.csv")
print(read_csv)

# Tokenization works like this
tidy_articles <- working_columns %>% unnest_tokens(word, Article) 

tidy_articles_no_stop_words <- working_columns %>% unnest_tokens(word, Article) %>% anti_join(stop_words)

sentiments <- get_sentiment_dictionary('nrc', 'english')
# Join sentiments and cleaned tweets
sentiment_article_word <- tidy_articles_no_stop_words  %>%
  inner_join(sentiments)

#windows(); 
sentiment_article_word %>% 
  
  # Count how often each word occurs, per sentiment
  count(word, sentiment, sort = T) %>% 
  ungroup() %>%
  
  # Only display words for two sentiments, fill in your choice
  filter(sentiment %in% c('positive', 'negative')) %>%
  mutate(word = reorder(word, n)) %>%
  acast(word ~ sentiment, value.var = "n", fill = 0) %>%
  # Define colors, maximum amount of words
  comparison.cloud(colors = c("red", "blue"),
                   max.words = 300) + theme_minimal()


print(filter(sentiment_article_word, sentiment == 'negative')$word)


sentiment_article_word %>% 
  # Count how often each word occurs, per sentiment
  count(word,sentiment,sort = T) %>% 
  ungroup() %>%
  
  # Only display words for two sentiments, fill in your choice
  filter(sentiment %in% c('negative')) %>%
  mutate(word = reorder(word, n)) %>%
  top_n(30)



sentiment_article_word %>% 
  # Count how often each word occurs, per sentiment
  count(word,sentiment,sort = T) %>% 
  ungroup() %>%
  
  # Only display words for two sentiments, fill in your choice
  filter(sentiment %in% c('positive', 'negative')) %>%
  mutate(word = reorder(word, n)) %>%
  top_n(35) %>%  
  ggplot(aes(n, word, fill = sentiment)) +
  geom_col() +
  facet_wrap(~ sentiment, scales = "free_y") +
  
  # Define labels for the axes and a title for the plot
  labs(x = 'Frequency (counts)', y = 'Word', title = "Most frequent words per sentiment (pos-neg)") +
  geom_text(aes(label = n), hjust = -0.51, color = 'black') +
  theme_minimal()



