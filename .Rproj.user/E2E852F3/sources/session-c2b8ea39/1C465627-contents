library(shiny)
library(tidyverse)
library(ggplot2)

taylorswift <- read.csv("taylorswift.csv") 
taylorswift$release_year <- substr(taylorswift$song_release_date, 1, 4)

df<-taylorswift
tswift <- df$song_page_views[c(1:14)]
fearless_plat <- df$song_page_views[c(15:32)]
fearless_tv <- df$song_page_views[c(33:57)]
speaknow_deluxe <- df$song_page_views[c(58:74)]
speaknow_tv <- df$song_page_views[c(75:96)]
red_deluxe <- df$song_page_views[c(97:116)]
red_tv <- df$song_page_views[c(117:146)]
birthyear_deluxe <- df$song_page_views[c(147:162)]
birthyear_tv <- df$song_page_views[c(163:184)]
reputation <- df$song_page_views[c(185:199)]
lover <- df$song_page_views[c(200:217)]
folklore_deluxe <- df$song_page_views[c(218:234)]
evermore_deluxe <- df$song_page_views[c(236:252)]
midnights <- df$song_page_views[c(254:276)]

tswift_avg <- sum(tswift) / length(tswift)
print(tswift_avg)

fearlessplat_avg <- sum(fearless_plat) / length(fearless_plat)
print(fearlessplat_avg)

fearlesstv_avg <- sum(fearless_tv) / length(fearless_tv)
print(fearlesstv_avg)

speaknowdeluxe_avg <- sum(speaknow_deluxe) / length(speaknow_deluxe)
print(speaknowdeluxe_avg)

speaknowtv_avg <- sum(speaknow_tv) / length(speaknow_tv)
print(speaknowtv_avg)

reddeluxe_avg <- sum(red_deluxe) / length(red_deluxe)
print(reddeluxe_avg)

redtv_avg <- sum(red_tv) / length(red_tv)
print(redtv_avg)

birthyeardeluxe_avg <- sum(birthyear_deluxe) / length(birthyear_deluxe)
print(birthyeardeluxe_avg)

birthyeartv_avg <- sum(birthyear_tv) / length(birthyear_tv)
print(birthyeartv_avg)

reputation_avg <- sum(reputation) / length(reputation)
print(reputation_avg)

lover_avg <- sum(lover) / length(lover)
print(lover_avg)

folklore_avg <- sum(folklore_deluxe) / length(folklore_deluxe)
print(folklore_avg)

evermore_avg <- sum(evermore_deluxe) / length(evermore_deluxe)
print(evermore_avg)

midnights_avg <- sum(midnights) / length(midnights)
print(midnights_avg)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Average Number of Views per Album"),
  mainPanel(
    plotOutput("distPlot")
  )
)

# Create a data frame with album names, release years, and their average views
album_avg_views <- data.frame(
  Album = c("Taylor Swift", "Fearless (Platinum)", "Fearless (Taylor's Version)", 
            "Speak Now (Deluxe Edition)", "Speak Now (Taylor's Version)",
            "Red (Deluxe Edition)", "Red (Taylor's Version)",
            "1989 (Deluxe Edition)", "1989 (Taylor's Version)",
            "Reputation", "Lover", "Folklore (Deluxe Edition)",
            "Evermore (Deluxe Edition)", "Midnight's"),
  Release_Year = c(2006, 2008, 2021, 2010, 2010, 2012, 2012, 2014, 2014, 2017, 2019, 2020, 2020, 2022),
  Average_Views = c(tswift_avg, fearlessplat_avg, fearlesstv_avg, 
                    speaknowdeluxe_avg, speaknowtv_avg,
                    reddeluxe_avg, redtv_avg,
                    birthyeardeluxe_avg, birthyeartv_avg,
                    reputation_avg, lover_avg,
                    folklore_avg, evermore_avg,
                    midnights_avg)
)

# Define UI for application
ui <- fluidPage(
  titlePanel("Average Number of Views per Album"),
  mainPanel(
    plotOutput("distPlot")
  )
)

# Define server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Plot line or dot graph of average views per album by release year
    ggplot(album_avg_views, aes(x = Release_Year, y = Average_Views, group = Album)) +
      geom_line() +  # You can also use geom_point() for a dot graph
      labs(title = "Average Number of Views per Album by Release Year",
           x = "Release Year", y = "Average Views")
  })
}

# Run the application
shinyApp(ui = ui, server = server)


# Create a data frame with album names and their average views
album_avg_views <- data.frame(
  Album = c("Taylor Swift", "Fearless (Platinum)", "Fearless (Taylor's Version)", 
            "Speak Now (Deluxe Edition)", "Speak Now (Taylor's Version)",
            "Red (Deluxe Edition)", "Red (Taylor's Version)",
            "1989 (Deluxe Edition)", "1989 (Taylor's Version)",
            "Reputation", "Lover", "Folklore (Deluxe Edition)",
            "Evermore (Deluxe Edition)", "Midnight's"),
  Average_Views = c(tswift_avg, fearlessplat_avg, fearlesstv_avg, 
                    speaknowdeluxe_avg, speaknowtv_avg,
                    reddeluxe_avg, redtv_avg,
                    birthyeardeluxe_avg, birthyeartv_avg,
                    reputation_avg, lover_avg,
                    folklore_avg, evermore_avg,
                    midnights_avg)
)

# Define server logic
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Plot bar chart of average views per album
    ggplot(album_avg_views, aes(x = Album, y = Average_Views)) +
      geom_bar(stat = "identity", fill = "darkred") +
      labs(title = "Average Number of Views per Album",
           x = "Album", y = "Average Views") +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
