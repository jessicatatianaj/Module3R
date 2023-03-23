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
library(dplyr)



tidy_articles <- working_columns %>% unnest_tokens(word, Article) 

tidy_articles_no_stop_words <- working_columns %>% unnest_tokens(word, Article) %>% anti_join(stop_words)

sentiments <- get_sentiment_dictionary('nrc', 'english')
# Join sentiments and cleaned tweets
sentiment_article_word <- tidy_articles_no_stop_words  %>%
  inner_join(sentiments)


mySentiment <- unique(sentiments$sentiment)
print(mySentiment)

sentiment_tibble <- tibble(mySentiment, count = 0)
eachArticle_tibble <- tibble(ArticleID = unique(sentiment_article_word$ID))
#eachArticle_tibble[ , 'surprise'] <- NA

result <- sentiment_article_word %>%
  group_by(sentiment_article_word$ID, sentiment_article_word$sentiment) %>%
  summarize(count = n(), .groups = "drop")

print(result)
print(colnames(result))

#print(is.vector(colnames(eachArticle_tibble)))

for(i in 1: nrow(result)) {
  myID <- pull(result[i,1])
  mySentiment <- pull(result[i,2])
  myCount <- pull(result[i,3])
  #test <- eachArticle_tibble[eachArticle_tibble$ArticleID == 1, ]
  eachArticle_tibble[eachArticle_tibble$ArticleID == myID, which(colnames(eachArticle_tibble) == mySentiment)] <- myCount
} 

eachArticle_tibble  <- eachArticle_tibble  %>%
  group_by(sentiment_article_word$ID) %>%
  mutate(count = 1) %>%
  spread(result, count, fill = 0)

# print the updated data frame
print(df)

# count for all variables
sentiment_tibble <- table(sentiment_article_word$sentiment)
print(sentiment_tibble)

write.csv(sentiment_tibble, "~/Documents/R_Projects/Module3R/data/articles/CorrectSentimentTable.csv", row.names = FALSE) 

write.csv(eachArticle_tibble, "~/Documents/R_Projects/Module3R/data/articles/EachArticleSentimentTable.csv", row.names = FALSE) 










