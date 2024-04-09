library(shiny)
# Sample 
taylorswift <- read.csv("taylorswift.csv") 

album <- album_title
genre <- song_tags

# Define UI for application
ui <- fluidPage(  titlePanel("Taylor Swift's Discography"),
                  sidebarLayout(    sidebarPanel(
                    selectInput("album", "Select an Album:", choices = unique(taylorswift$album))    ),
                    mainPanel(      plotOutput("album_plot")
                    )  )
)
# Define server logic
server <- function(input, output) {
  output$album_plot <- renderPlot({
    selected_album <- taylorswift[taylorswift$album == input$album, ]
    barplot(table(selected_album$genre), main = paste("Genres in", input$album), xlab = "Genre", ylab = "Count")
  })
}

# Run the application
shinyApp(ui = ui, server = server)