library(shiny)
library(tidyverse)
# Sample 
taylorswift <- read.csv("taylorswift.csv") 

# 1: map the genres of her albums over the years 
# Define UI for application
ui <- fluidPage(  titlePanel("An Analysis of Taylor Swift's Discography"),
                  sidebarLayout(    sidebarPanel(
                    selectInput("album", "Select an Album", choices = unique(taylorswift$album_title)), actionButton("Start","Generate Analysis")),
                    mainPanel( tabsetPanel(tabPanel("Genres Over The Years", plotOutput("timePlot")) )
                    )  )
)
# Define server logic

server <- function(input, output) {
  output$timePlot <- renderPlot({
    df <- taylorswift %>%
      filter(album_title == input$album_title) %>%  # Use album_title instead of Album
      group_by(genre) %>%
      summarise(n = n())  # Use summarise() instead of count() for dplyr version > 1.0.0
    
    if (nrow(df) > 0) {
      ggplot(df, aes(x = genre, y = n, group = 1, color = as.factor(input$album_title))) + 
        geom_line() + 
        geom_point() + 
        theme_minimal() + 
        labs(title = "Genres Over Albums", x = "Genres", y = "Count") +  # Corrected y-axis label
        theme(axis.text.x = element_text(angle = 60))
    }
  })
}

shinyApp(ui = ui, server = server)

#2: Here I want to extract keywords (colours) from the column "song_lyrics" and count their frequency
song_lyrics <- data.frame(
  stringsAsFactors = FALSE
)

# Define the keyword to search for
keyword <- colours()

# Tokenize the lyrics to extract individual words
words <- str_split(song_lyrics$lyrics, "\\s+") %>%
  unlist()

# Count the frequency of the keyword
keyword_frequency <- sum(words == keyword)

# Create a data frame for visualization
keyword_data <- data.frame(keyword = keyword, frequency = keyword_frequency)

# Create a bar plot to visualize the keyword frequency
ggplot(keyword_data, aes(x = keyword, y = frequency)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.5) +
  ggtitle("Keyword Frequency in Song Lyrics") +
  xlab("Keyword") +
  ylab("Frequency")

# Run the application
shinyApp(ui = ui, server = server)


ui <- navbarPage(title = "Player",
                 tabPanel(id = "tab",
                          title = strong("Taylor Swift"),
                          icon = icon("circle-info"),  
                          sidebarLayout(
                            sidebarPanel = '', 
                            mainPanel(
                              tags$iframe(
                                style="border-radius:12px", 
                                src="https://open.spotify.com/embed/artist/06HL4z0CvFAxyc27GXpf02?utm_source=generator", 
                                width="100%", 
                                height="380", 
                                frameBorder="0", 
                                allowfullscreen="", 
                                allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture", 
                                loading="lazy")
                            )
                          )
                 )
)

server <- function(input,output,session){}

# 3: plot the number of page views per song in each album (show increasing or decreasing)



