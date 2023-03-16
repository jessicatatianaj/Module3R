install.packages("LexisNexisTools") 

library("LexisNexisTools") 
library('dplyr')

lexisData <- lnt_read("~/Documents/R_Projects/Module3R/data/articles/1-100.DOCX",extract_paragraphs = T, verbose=T,file_type =  
                        'docx', encoding = 'UTF-8') 

lexisDataTwo <- lnt_read("~/Documents/R_Projects/Module3R/data/articles/101-200.DOCX",extract_paragraphs = T, verbose=T,file_type =  
                           'docx', encoding = 'UTF-8') 

lexisDataThree <- lnt_read("~/Documents/R_Projects/Module3R/data/articles/201-300.DOCX",extract_paragraphs = T, verbose=T,file_type =  
                             'docx', encoding = 'UTF-8')

lexisDataFour <- lnt_read("~/Documents/R_Projects/Module3R/data/articles/301-400.DOCX",extract_paragraphs = T, verbose=T,file_type =  
                             'docx', encoding = 'UTF-8')

lexisDataFive <- lnt_read("~/Documents/R_Projects/Module3R/data/articles/401-500.DOCX",extract_paragraphs = T, verbose=T,file_type =  
                             'docx', encoding = 'UTF-8')

metadata <- lexisData@meta
print(metadata)

lexisPara <- lexisData@paragraphs 
print(lexisPara)

lexisArticles <- lexisData@articles
print(lexisArticles)

# head(lexisArticles, 1) # to print a row of the dataframe (tibble) use head
#print(subset(lexisArticles, select = c("Article"))) # show column by name as a small dataframe
#lexisArticles$Article # show column by name as a vector (like an array)
#oneArticle <- lexisArticles %>% slice(1,1)

news <- merge(metadata, lexisArticles)  
print(news)
#colnames(news) # print all columnsnames of a dataframe
#row.names(news) # print all rownames of a dataframe

metadataTwo <- lexisDataTwo@meta
lexisArticlesTwo <- lexisDataTwo@articles
newsTwo <- merge(metadataTwo, lexisArticlesTwo) 

metadataThree <- lexisDataThree@meta
lexisArticlesThree <- lexisDataThree@articles
newsThree <- merge(metadataThree, lexisArticlesThree) 


metadataFour <- lexisDataFour@meta
lexisArticlesFour <- lexisDataFour@articles
newsFour <- merge(metadataFour, lexisArticlesFour) 

metadataFive <- lexisDataFive@meta
lexisArticlesFive <- lexisDataFive@articles
newsFive <- merge(metadataFive, lexisArticlesFive) 

allNews <- rbind(news, newsTwo, newsThree, newsFour, newsFive)
write.csv(allNews, "~/Documents/R_Projects/Module3R/data/articles/AllNews.csv", row.names = FALSE) 

duplicated(allNews) # True specifies which elements of a data frame are duplicated and False which are not duplicated


