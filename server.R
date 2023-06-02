source("global.R")


function(input, output) {
  
  most_popular_track <- reactive({
    spotify_data %>%
      arrange(desc(popularity)) %>%
      slice(1)
  })
  
  output$mostPopularTrackName <- renderUI({
    most_popular_track()$track_name
  })
  
  output$mostPopularTrackArtist <- renderUI({
    most_popular_track()$artists
  })
  
  output$mostPopularTrackAlbum <- renderUI({
    most_popular_track()$album_name
  })
  
  genreFilter <- reactive({
    req(input$genres)
    spotify_data %>%
      filter(track_genre %in% input$genres)
  })
  
output$topTracksPlot <- renderPlotly({
  genreFilteredData <- genreFilter()
  top_tracks <- genreFilteredData %>%
    group_by(track_name, artists) %>%
    summarise(popularity = max(popularity), .groups = "drop") %>%
    arrange(desc(popularity)) %>%
    head(10)
  
  # Shorten song titles if necessary
  top_tracks$track_name2 <- ifelse(nchar(top_tracks$track_name) > 10, 
                                  paste0(substr(top_tracks$track_name, 1, 3), "..."), 
                                  top_tracks$track_name)
  
  # Making sure the order is maintained in the plot
  top_tracks <- mutate(top_tracks, track_name2 = factor(track_name2, levels = rev(top_tracks$track_name2)))
  
  plot_ly(top_tracks, x = ~popularity, y = ~track_name2, type = 'bar', orientation = 'h',
          hoverinfo = 'text',
          hovertext = ~paste('Track Name: :',track_name,'<br>Artist:', artists, '<br>Popularity:', popularity),
          marker = list(color = '#20bc9c', line = list(color = 'rgb(8,48,107)', width = 1.5))) %>%
    layout(title = "Top Ten Popular Tracks by Genre", xaxis = list(title = "Popularity"), yaxis = list(title = ""))
})
  


  
  output$table <- DT::renderDataTable({
    spotify_data %>%
      select(track_name, artists, album_name, duration_ms, track_genre, released_year) %>%
      DT::datatable(options = list(pageLength = 5, scrollX = TRUE, searchHighlight = TRUE))
  })


}

