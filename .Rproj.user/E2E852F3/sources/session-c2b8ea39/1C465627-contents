library(shiny)
library(tidyverse)

taylorswift <- read.csv("taylorswift.csv") 
taylorswift$release_year <- substr(taylorswift$song_release_date, 1, 4)

# Define UI for application that draws a histogram
ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      sliderInput("year", "Select Year", min = 2006, max = 2023, value = 2010, step = 1)
    ),
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Filter the data based on the selected year
    year_filtered <- taylorswift %>%
      filter(release_year == input$year)
    
    # Plot histogram of page views against time for each song released in that year
    hist(year_filtered$song_page_views, col = 'darkorchid', xlab = "Page Views", main = paste("Page Views Distribution for Songs Released in", input$year))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

