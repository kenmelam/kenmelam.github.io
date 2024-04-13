# Load necessary libraries
library(stringr)
library(dplyr)
library(ggplot2)
library(tidyr)

# Read the dataset
data <- read.csv("taylorswift.csv", stringsAsFactors = FALSE)

# filter out unwanted albums
included_albums <- c("Taylor Swift", "Fearless (Platinum Edition)", "Fearless (Taylor's Version)", 
                     "Speak Now (Deluxe)", "Speak Now (Taylor's Version)",
                     "Red (Deluxe Version)", "Red (Taylor's Version)",
                     "1989 (Deluxe)", "1989 (Taylor's Version) [Tangerine Edition]",
                     "reputation", "Lover", "folklore (deluxe version)",
                     "evermore (deluxe version)", "Midnights (3am Edition)")

colors <- c("red", "blue", "green", "yellow", "black", "white", "pink", "purple", "orange", "brown", "grey", "gray", "silver", "gold", "golden", "maroon", "lavender", "sapphire","violet","crimson","scarlet", "burgundy")

pattern <- paste(colors, collapse = "|")

# Filter for specified albums, extract colors, and count per album
color_counts_per_album <- data %>%
  filter(album_title %in% included_albums) %>% # Keep only the specified albums
  mutate(matched_colors = str_extract_all(song_lyrics, pattern)) %>%
  unnest(matched_colors) %>%
  filter(length(matched_colors) > 0) %>%
  group_by(album_title, matched_colors) %>%
  summarise(color_count = n(), .groups = "drop") %>%
  ungroup()

color_palette <- c(
  red = "#FF0000",
  blue = "#0000FF",
  green = "#008000",
  yellow = "#FFFF00",
  black = "#000000",
  white = "#FFFFFF",
  pink = "#FFC0CB",
  purple = "#800080",
  orange = "#FFA500",
  brown = "#A52A2A",
  gray = "#808080",
  grey = "#808080",
  silver = "#C0C0C0",
  gold = "#FFD700",
  golden = "#FFD700", 
  maroon = "#800000",
  lavender = "#E6E6FA",
  sapphire = "#0F52BA",
  violet = "#8F00FF",
  crimson = "#DC143C",
  scarlet = "#FF2400",
  burgundy = "#800020"
)



ggplot(color_counts_per_album, aes(x = matched_colors, y = color_count, fill = matched_colors)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = color_palette) + 
  facet_wrap(~ album_title, scales = "free_y", ncol = 1) + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(x = "Color", y = "Count", title = "Color Frequency per Album in Song Lyrics") +
  theme_minimal() +
  theme(legend.position = "bottom", legend.title = element_blank())

# Define the UI
ui <- fluidPage(
  titlePanel("Color Frequency per Album in Song Lyrics"),
  sidebarLayout(
    sidebarPanel(
      selectInput("selectedAlbum",
                  "Choose an Album:",
                  choices = c("Taylor Swift", "Fearless (Platinum Edition)", "Fearless (Taylor's Version)", 
                              "Speak Now (Deluxe)", "Speak Now (Taylor's Version)",
                              "Red (Deluxe Version)", "Red (Taylor's Version)",
                              "1989 (Deluxe)", "1989 (Taylor's Version) [Tangerine Edition]",
                              "reputation", "Lover", "folklore (deluxe version)",
                              "evermore (deluxe version)", "Midnights (3am Edition)"),
                  selected = "Taylor Swift")
    ),
    mainPanel(
      plotOutput("colorHistogram")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  output$colorHistogram <- renderPlot({

    filtered_data <- color_counts_per_album %>%
      filter(album_title == input$selectedAlbum)
    
    ggplot(filtered_data, aes(x = matched_colors, y = color_count, fill = matched_colors)) +
      geom_bar(stat = "identity") +
      scale_fill_manual(values = color_palette) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(x = "Color", y = "Count", title = paste("Color Frequency in", input$selectedAlbum)) +
      theme_minimal() +
      theme(legend.position = "bottom", legend.title = element_blank(),
            ) +
      guides(fill = "none")
  })
}

# Run the application
shinyApp(ui = ui, server = server)
