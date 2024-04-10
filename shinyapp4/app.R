library(tidyverse)

# Sample data
song_lyrics <- data.frame(
  song_lyrics = c("red blue green yellow blue red green", "blue green yellow red"),
  release_year <- ,
  stringsAsFactors = FALSE
)

# Vector of colors (keywords)
keywords <- c("red", "blue", "green", "yellow")

# Function to count keyword frequencies for a given set of lyrics
count_keyword_frequencies <- function(lyrics, keywords) {
  words <- unlist(str_split(lyrics, "\\s+"))
  keyword_frequency <- table(factor(words, levels = keywords))
  return(keyword_frequency)
}

# Apply the function to each song lyrics and combine the results
keyword_frequencies <- song_lyrics %>%
  group_by(release_year) %>%
  summarise(keyword_count = list(count_keyword_frequencies(song_lyrics, keywords))) %>%
  unnest(keyword_count)

# Plot grouped bar graph
ggplot(keyword_frequencies, aes(x = keyword, y = Freq, fill = as.factor(release_year))) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Keyword Frequency in Song Lyrics by Year",
       x = "Keyword",
       y = "Frequency",
       fill = "Year") +
  theme_minimal()

# Run the application 
shinyApp(ui = ui, server = server)
