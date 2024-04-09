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

shinyApp(ui = ui, server = server)