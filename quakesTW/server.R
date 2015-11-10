library(shiny)
library(leaflet)
library(RColorBrewer)
quakesTW <- readRDS("data/quakesTW.rds")

server <- function(input, output, session) {
  
  # Reactive expression for the data subsetted to what the user selected
  filteredData <- reactive({
    quakesTW[quakesTW$mag >= input$magnitude[1] & quakesTW$mag <= input$magnitude[2] & quakesTW$yearPart >= input$year[1] & quakesTW$yearPart <= input$year[2] & quakesTW$depth >= input$depth[1] & quakesTW$depth <= input$depth[2],]
  })
  
  output$map <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    pal <- colorNumeric(
      palette = "Greens",
      domain = -quakesTW$depth
    )
    
    leaflet(quakesTW) %>% addTiles() %>%
      fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))%>%
      addLegend("bottomright", pal = pal, values = ~(-depth),
                title = "Depth(km)",
                opacity = 0.5)
  })
  
  # Incremental changes to the map (in this case, replacing the
  # circles when a new color is chosen) should be performed in
  # an observer. Each independent set of things that can change
  # should be managed in its own observer.
  observe({
    pal <- colorNumeric(
      palette = "Greens",
      domain = -quakesTW$depth
    )
    
    leafletProxy("map", data = filteredData()) %>%
      clearShapes() %>%
      addCircles(radius = ~10^mag/100, weight = 1, color = ~pal(-depth),
                 fillColor = ~pal(-depth), fillOpacity = 0.5, popup = ~paste(dateTime,"<br>", "Magnitude: ", mag, "<br>", "Depth: ", depth)
      )
  })
}