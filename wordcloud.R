

# Loading the libraries
library(tm)
library(wordcloud)
library(RColorBrewer)

text<-"House Targaryen is one of the Great Houses of Westeros.
They are known for their dragons, silver hair, and motto: 'Fire and Blood'.
The Targaryens ruled the Seven Kingdoms for nearly 300 years after Aegon the Conqueror.
Daenerys Targaryen, also known as the Mother of Dragons, played a major role in the events of Game of Thrones.
Their ancestral seat is Dragonstone. Valyrian heritage flows through their blood."

# Preprocessing

corpus<-Corpus(VectorSource(text))
corpus<-tm_map(corpus,content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))
corpus <- tm_map(corpus, stripWhitespace)

# Term document and frequency

tdm <- TermDocumentMatrix(corpus)
matrix <- as.matrix(tdm)
word_freqs <- sort(rowSums(matrix), decreasing = TRUE)
df <- data.frame(word = names(word_freqs), freq = word_freqs)

# Saving as image
png("targaryen_wordcloud.png", width = 800, height = 600)
set.seed(1234)
wordcloud(words = df$word,
          freq = df$freq,
          min.freq = 1,
          max.words = 100,
          random.order = FALSE,
          rot.per = 0.35,
          colors = brewer.pal(8, "Reds"))
dev.off()
