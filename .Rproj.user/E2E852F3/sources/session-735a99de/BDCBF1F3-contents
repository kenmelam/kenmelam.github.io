library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(tidyverse)

ui <- fluidPage(
  titlePanel("Boxplot of Song Page Views by Producer"),
  helpText("Hover over each boxplot to view more detailed information!"),
  plotlyOutput("producerPlot")  
)

server <- function(input, output) {
  taylorswift <- read.csv("taylorswift.csv")  # Adjust path as needed
  
  taylorswift <- taylorswift %>%
    mutate(song_producers = strsplit(as.character(song_producers), ",")) %>%
    unnest(song_producers) %>%
    mutate(song_producers = gsub("[[:punct:]]", "", song_producers),  # Remove punctuation
           song_producers = trimws(song_producers))  # Trim whitespace
  
  # Avg song page views per producer and remove decimals
  producer_views <- taylorswift %>%
    group_by(song_producers) %>%
    summarize(average_page_views = mean(song_page_views, na.rm = TRUE), .groups = 'drop') %>%
    mutate(formatted_views = format(round(average_page_views, 0), big.mark = ","))  # No decimals
  
  # Filter out top 10 producers
  top_producers <- producer_views %>%
    slice_max(order_by = average_page_views, n = 10) %>%
    pull(song_producers)

  filtered_data <- taylorswift %>%
    filter(song_producers %in% top_producers) %>%
    left_join(producer_views, by = "song_producers")
  
  output$producerPlot <- renderPlotly({
    p <- ggplot(filtered_data, aes(x = song_producers, y = song_page_views, fill = song_producers)) +
      geom_boxplot() +
      labs(title = "Distribution of Song Page Views by Top Producers",
           x = "Producer", y = "Song Page Views") +
      scale_fill_brewer(palette = "Paired") + 
      theme(axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1), legend.position = "none")
    
    # Using plotly here, learned from the internet.. hahaha
    ggplotly(p, tooltip = c("song_producers", "formatted_views"))  # Custom tooltip with formatted views
  })
}

# Run the application
shinyApp(ui = ui, server = server)
