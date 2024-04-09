library(shiny)
library(tidyverse)
# Sample 
taylorswift <- read.csv("taylorswift.csv") 

library(stringr)
library(ggplot2)

genres <- c('Country', 'English', 'USA', 'Country Rock', 'American Folk', 'Folk', 'Ballad')
cur_col <- taylorswift$song_tags
taylorswift$Country = as.numeric(str_detect(cur_col, pattern = genres[[1]]))
taylorswift$English = as.numeric(str_detect(cur_col, pattern = genres[[2]]))
taylorswift$USA = as.numeric(str_detect(cur_col, pattern = genres[[3]]))
taylorswift$Country_Rock = as.numeric(str_detect(cur_col, pattern = genres[[4]]))
taylorswift$American_Folk = as.numeric(str_detect(cur_col, pattern = genres[[5]]))
taylorswift$Folk = as.numeric(str_detect(cur_col, pattern = genres[[6]]))
taylorswift$Ballad = as.numeric(str_detect(cur_col, pattern = genres[[7]]))


# 1: plot bar chart for different genres present in her albums  
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
      filter(album_title == input$album_title)
    
    if (nrow(df) > 0) {
      df %>%
        select(Country:Ballad) %>%
        pivot_longer(Country:Ballad, names_to = "genre", values_to = "val") %>%
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
