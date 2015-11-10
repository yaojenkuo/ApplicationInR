library(shiny)
library(leaflet)
library(RColorBrewer)
quakesTW <- readRDS("data/quakesTW.rds")

ui <- bootstrapPage(
  tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
  leafletOutput("map", width = "100%", height = "100%"),
  absolutePanel(top = 10, right = 10,
                sliderInput("year", "Year", min(quakesTW$yearPart), max(quakesTW$yearPart),
                            value = range(quakesTW$yearPart), step = 1
                )
  ),
  absolutePanel(top = 100, right = 10,
                sliderInput("magnitude", "Magnitudes", min(quakesTW$mag), max(quakesTW$mag),
                            value = range(quakesTW$mag), step = 0.1
                )
  ),
  absolutePanel(top = 190, right = 10,
                sliderInput("depth", "Depth", min(quakesTW$depth), max(quakesTW$depth),
                            value = range(quakesTW$depth), step = 0.1
                )
  )
)
