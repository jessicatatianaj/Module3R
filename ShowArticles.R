install.packages("hcandersenr") 
install.packages("tidyverse") 
install.packages("tidytext") 
install.packages("stringr") 
install.packages("tibble") 
install.packages("ggplot2") 

library(hcandersenr)
library(tidyverse)
library(tidytext)
library(stringr)
library(dplyr)
library(tibble)
library(ggplot2)

read_csv = read.csv("~/Documents/R_Projects/Module3R/data/articles/AllNews.csv")
print(read_csv)

read_csv %>% 
  head(5)

read_csv %>% 
  glimpse()

# variables for analysis we include: Newspaper, Date, Article, Author

# Choose the important columns
variables_for_analysis <- c("Newspaper", "Author","Date","Article", "ID")

working_columns <- read_csv %>% select(all_of(variables_for_analysis)) # selecting only the columns that are specified in the variables_for_analysis

# Tokenization works like this
# tidy_articles <- working_columns %>% unnest_tokens(word, Article) 

# tidy_articles %>% count(word) %>% arrange(desc(n))

# tidy_articles_no_stop_words <- working_columns %>% unnest_tokens(word, Article) %>% anti_join(stop_words)

# tidy_articles_no_stop_words %>% count(word) %>% arrange(desc(n))


# Check for duplicate articles
# Jaccard index calculates the intersection over Union
articles_tokens <- working_columns %>%
  mutate(tokens = str_split(Article, "(?=.)")) # split per character for tokens

articleSplit <- articles_tokens # article Split contains a new column called tokens for each article
# can finish 

# extract stakeholders
lexicon_stakeholders <- c("government", "geothermal companies", "concerned groups", "investors", "researchers", "media platform", "consumers", "tourist")

stakeholder_tibble <- tibble(ArticleID = working_columns$ID)

# for each article 
for (pattern in lexicon_stakeholders) {
  print(pattern)
  countResult <- working_columns$Article %>% str_count(pattern)
  stakeholder_tibble <- add_column(stakeholder_tibble, "{pattern}" := countResult)
}

# save stakeholder_tibble to a csv file
write.csv(stakeholder_tibble, "~/Documents/R_Projects/Module3R/data/articles/simpleStakeholderAnalysis.csv", row.names = FALSE) 

Allstakeholders_tibble = tibble(stakeholder = lexicon_stakeholders, count = 0)

for (pattern in lexicon_stakeholders) {
  print(pattern)
  countResult <- sum(str_count(working_columns$Article, pattern))
  print(countResult)
  Allstakeholders_tibble$count[Allstakeholders_tibble$stakeholder == pattern] <- countResult
}

write.csv(Allstakeholders_tibble, "~/Documents/R_Projects/Module3R/data/articles/simple_for_all_StakeholderAnalysis.csv", row.names = FALSE) 


# Plot a line graph
ggplot(Allstakeholders_tibble, aes(x = stakeholder, y = count)) +
  geom_bar(stat = "identity")




