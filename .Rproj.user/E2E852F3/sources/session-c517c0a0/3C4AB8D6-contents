library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("About The Project"),
  
  fluidRow(
    column(width = 12,
           tags$div(
             style = "text-align:center;",
             tags$img(src = "taylor.png", height = "auto", width = "50%")
           )
    )
  ),
  
  fluidRow(
    column(width = 12,
           h2("Welcome to Kenme's project website!"),
           p("I am a second-year Communications & New Media student at NUS. I'm interested in fashion, pop culture and the media (of course)! Hence, my project is about Taylor Swift's music and how it resonates with audiences. This looks at the genres of music she has produced and its correlation with its popularity, as well as the use of certain themes or lyrics.")
    )
  )
)

server <- function(input, output) {
    observeEvent(input$taylor_image, {
      showModal(modalDialog(
        title = "Image Clicked",
        "Yup, that's Taylor Swift!"
      ))
    })
  }
  

# Run the application 
shinyApp(ui = ui, server = server)
