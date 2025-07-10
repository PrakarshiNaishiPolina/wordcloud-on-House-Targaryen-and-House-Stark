

library(tm)
library(wordcloud)
library(RColorBrewer)

stark_text <- "House Stark is one of the Great Houses of Westeros.
They rule the North from their seat in Winterfell.
Their motto is 'Winter is Coming', a stark warning and a reminder.
The Starks are known for honor, loyalty, and a deep connection to the old gods.
Key members include Eddard Stark, Robb Stark, Arya Stark, Sansa Stark, and Jon Snow.
Direwolves are their sigil, symbolizing strength and family bonds.
House Stark played a central role in the War of the Five Kings and the Battle of the Bastards."

corpus <- Corpus(VectorSource(stark_text))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

tdm <- TermDocumentMatrix(corpus)
matrix <- as.matrix(tdm)
word_freqs <- sort(rowSums(matrix), decreasing = TRUE)
df <- data.frame(word = names(word_freqs), freq = word_freqs)

png("stark_wordcloud.png", width = 800, height = 600)
par(bg="white")
set.seed(5678) 
wordcloud(words = df$word,
          freq = df$freq,
          min.freq = 1,
          max.words = 100,
          random.order = FALSE,
          rot.per = 0.6,
          colors = c(
            "#0B3C5D",  
            "#1D2731",  
            "#328CC1",  
            "#276FBF", 
            "#003F91",  
            "#3A506B", 
            "#2C3E50"   
          ))
dev.off()
