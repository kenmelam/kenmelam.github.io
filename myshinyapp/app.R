library(shiny)
# Sample 
swift_discography <- data.frame(
Album = c("Taylor Swift", "Fearless", "Speak Now", "Red", "1989", "Reputation", "Lover", "folklore", "evermore"),  Release_Year = c(2006, 2008, 2010, 2012, 2014, 2017, 2019, 2020, 2020),
Genre = c("Country", "Country/Pop", "Country/Pop", "Pop", "Pop", "Pop", "Pop", "Indie Folk", "Indie Folk"))
# Define UI for application
ui <- fluidPage(  titlePanel("Taylor Swift's Discography"),
                  sidebarLayout(    sidebarPanel(
                    selectInput("album", "Select an Album:", choices = unique(swift_discography$Album))    ),
                    mainPanel(      plotOutput("album_plot")
                    )  )
)
# Define server logic
server <- function(input, output) {
  output$album_plot <- renderPlot({
    selected_album <- swift_discography[swift_discography$Album == input$album, ]
    barplot(table(selected_album$Genre), main = paste("Genres in", input$album), xlab = "Genre", ylab = "Count")
  })
}

# Run the application
shinyApp(ui = ui, server = server)