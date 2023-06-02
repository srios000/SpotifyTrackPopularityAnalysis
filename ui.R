source("global.R")

dashboardPage(

  dashboardHeader(title = "Spotify Track Popularity Analysis Dashboard", titleWidth = 300),
  dashboardSidebar(width = 300,
                   sidebarMenu(
                     menuItem("Home", tabName = "home", icon = shiny::icon("home")),
                     menuItem("Top Tracks", tabName = "top_tracks", icon = shiny::icon("music")),
                     menuItem("Reference", tabName = "Reference", icon = shiny::icon("book"))
                   )
  ),
  dashboardBody(
    shinyDashboardThemes(
      theme = "poor_mans_flatly"
    ),
    tabItems(
      tabItem(tabName = "home",
              fluidPage(
                box(
                  title = "LBB3: Spotify Track Popularity Analysis", status = "primary", solidHeader = TRUE, width = 12,
                  "By Sintario Satya",
                  br(),
                  "This dataset contains a list of tracks with their respective features and attributes as measured by Spotify.",
                  br(),
                  "Fields include:",
                  tags$ul(
                    tags$li("track_id: The Spotify ID for the track"),
                    tags$li("artists: The artists' names who performed the track"),
                    tags$li("album_name: The album name in which the track appears"),
                    tags$li("track_name: Name of the track"),
                    tags$li("popularity: The popularity of a track"),
                    tags$li("track_genre: The genre in which the track belongs"),
                    tags$li("duration_ms: The track length in milliseconds"),
                    tags$li("explicit: Whether or not the track has explicit lyrics"),
                    tags$li("danceability: Danceability describes how suitable a track is for dancing"),
                    tags$li("energy: A measure of intensity and activity in a track"),
                    tags$li("key: The key the track is in"),
                    tags$li("loudness: The overall loudness of a track in decibels"),
                    tags$li("mode: Indicates the modality (major or minor) of a track"),
                    tags$li("speechiness: Detects the presence of spoken words in a track"),
                    tags$li("acousticness: A confidence measure of whether the track is acoustic"),
                    tags$li("instrumentalness: Predicts whether a track contains no vocals"),
                    tags$li("liveness: Detects the presence of an audience in the recording"),
                    tags$li("valence: A measure of musical positiveness conveyed by a track"),
                    tags$li("tempo: The estimated tempo of a track in beats per minute"),
                    tags$li("time_signature: An estimated time signature of a track"),
                    tags$li("released_year: Release year of the song")
                  )
                )
              )
            ),
            tabItem(tabName = "top_tracks",
                    fluidPage(
                      #shinythemes::themeSelector(),  
                      box(width = 4,
                          title = "Most Popular Track's Name", status = "primary", solidHeader = TRUE,
                          uiOutput("mostPopularTrackName")
                      ),
                      box(width = 4,
                          title = "Most Popular Track's Artists", status = "primary", solidHeader = TRUE,
                          uiOutput("mostPopularTrackArtist")
                      ),
                      box(width = 4,
                          title = "Most Popular Track's Album Name", status = "primary", solidHeader = TRUE,
                          uiOutput("mostPopularTrackAlbum")
                      ),
                      box(width = 12, status = "primary", solidHeader = TRUE,
                          plotlyOutput("topTracksPlot")
                      ),
                      tags$head(tags$style(HTML('
                        .multicolumn {
                          column-count: 4;
                          column-gap: 1em;
                        }
                      '))),
                                          
                          checkboxGroupInput("genres", label = h3("Genre selection"), 
                                             choices = unique(spotify_data$track_genre),
                                             selected = NULL,
                                             inline = TRUE),
                      
                      box(width = 12, status = "primary", solidHeader = TRUE,
                          DT::dataTableOutput("table")
                      )
                    )
            ),
      
     
      tabItem(tabName = "Reference",
              fluidPage(
                box(
                  title = "Reference", status = "primary", solidHeader = TRUE, width = 12,
                  "Reference:",
                  tags$ul(
                    tags$li("Dataset: ", tags$a(href="https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset", "Click here!")),
                    tags$li("I retrieved more record and add 'released_year' column by scrapping from ", tags$a(href="https://developer.spotify.com", "Spotify API.")),
                  )
                )
              )
      )
      # Add more tabItem elements for additional tabs
      
    )
  )

)
