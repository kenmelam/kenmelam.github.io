library(shiny)
library(tidyverse)
# Sample 
taylorswift <- read.csv("taylorswift.csv") 

library(stringr)
library(ggplot2)

genres <- c('Country', 'Country Rock', 'American Folk', 'Folk', 'Ballad', 'Pop')
cur_col <- taylorswift$song_tags
taylorswift$Country = as.numeric(str_detect(cur_col, pattern = genres[[1]]))
taylorswift$Country_Rock = as.numeric(str_detect(cur_col, pattern = genres[[2]]))
taylorswift$American_Folk = as.numeric(str_detect(cur_col, pattern = genres[[3]]))
taylorswift$Folk = as.numeric(str_detect(cur_col, pattern = genres[[4]]))
taylorswift$Ballad = as.numeric(str_detect(cur_col, pattern = genres[[5]]))
taylorswift$Pop = as.numeric(str_detect(cur_col, pattern = genres[[6]]))

included_albums <- c("Taylor Swift", "Fearless (Platinum Edition)", "Fearless (Taylor's Version)", 
                     "Speak Now (Deluxe)", "Speak Now (Taylor's Version)",
                     "Red (Deluxe Version)", "Red (Taylor's Version)",
                     "1989 (Deluxe)", "1989 (Taylor's Version) [Tangerine Edition]",
                     "reputation", "Lover", "folklore (deluxe version)",
                     "evermore (deluxe version)", "Midnights (3am Edition)")

# 1: plot bar chart for different genres present in her albums  
# Define UI for application
ui <- fluidPage(  titlePanel("Genres Covered Per Album"),
                  sidebarLayout(    sidebarPanel(
                    selectInput("album_title", "Select an Album", choices = included_albums), actionButton("Start","Generate Analysis")),
                    mainPanel( tabsetPanel(tabPanel("Genres Covered", plotOutput("genreplot")) )
                    )  )
)
# Define server logic

server <- function(input, output) {
  output$genreplot <- renderPlot({
    df <- taylorswift %>%
      filter(album_title == input$album_title)
    
    if (nrow(df) > 0) {
      df %>%
        select(Country:Pop) %>%
        pivot_longer(Country:Pop, names_to = "genre", values_to = "val") %>%
        group_by(genre) %>%
        summarise(n = mean(val, na.rm = T)) %>%
      ggplot(aes(x = genre, y = n, fill = genre)) + 
        geom_bar(stat = "identity") + 
        theme_minimal() + 
        labs(title = "Genres Covered in Selected Album", x = "Genres", y = "Count") +
        scale_fill_discrete(name = "Genre") +
        scale_fill_viridis_d()
    }
  })
}

shinyApp(ui = ui, server = server)
