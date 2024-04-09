library(shiny)
library(tidyverse)
# Sample 
taylorswift <- read.csv("taylorswift.csv") 

# 1: plot the different genres present in her albums  
# Define UI for application
ui <- fluidPage(  titlePanel("An Analysis of Taylor Swift's Discography"),
                  sidebarLayout(    sidebarPanel(
                    selectInput("album_title", "Select an Album", choices = unique(taylorswift$album_title)), actionButton("Start","Generate Analysis")),
                    mainPanel( tabsetPanel(tabPanel("Genres Covered", plotOutput("genreplot")) )
                    )  )
)
# Define server logic

server <- function(input, output) {
  output$genreplot <- renderPlot({
    df <- taylorswift %>%
      filter(album_title == input$album_title) %>%  
      group_by(genre_vectors) %>%
      summarise(n = n()) 
    
    if (nrow(df) > 0) {
      ggplot(df, aes(x = genre_vectors, y = n, fill = genre_vectors)) + 
        geom_bar(stat = "identity") + 
        theme_minimal() + 
        labs(title = "Genres Covered in Selected Album", x = "Genres", y = "Count") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        scale_fill_discrete(name = "Genre")
    }
  })
}

shinyApp(ui = ui, server = server)
