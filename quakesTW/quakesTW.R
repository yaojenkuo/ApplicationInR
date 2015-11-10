install.packages("leaflet")
library(leaflet)
m <- leaflet() %>% setView(lng = -71.0589, lat = 42.3601, zoom = 4)
m %>% addProviderTiles("NASAGIBS.ViirsEarthAtNight2012")

topoData <- readLines("C:/topoJSON/examples/us-10m.json") %>% paste(collapse = "\n")

leaflet() %>% setView(lng = -98.583, lat = 39.833, zoom = 3) %>%
  addProviderTiles("NASAGIBS.ViirsEarthAtNight2012") %>%
  addTopoJSON(topoData, weight = 1, color = "#444444", fill = FALSE)

library(chron)
quakesTW <- read.csv("C:/ApplicationInR/quakesTW/data/quakesTW.csv", stringsAsFactors=F)
colnames(quakesTW)[1] <- "datetime"
datetimeSplit <- strsplit(quakesTW$datetime, split=' ')
datePart <- c()
timePart <- c()
for (index in c(1:length(datetimeSplit))){
  datePart[index] <- datetimeSplit[[index]][1]
  timePart[index] <- datetimeSplit[[index]][2]
}

datePartNew <- as.Date(datePart, "%m/%d/%Y")
timePartNew <- chron(times=timePart, format=c(times='h:m:s'))
quakes <- cbind(quakesTW, datePartNew, timePartNew)
colnames(quakes)[6:7] <- c("datePart", "timePart")
quakes$yearPart <- as.numeric(format(quakes$datePart, "%Y"))
quakes$dateTime <- paste(quakes$datePart, quakes$timePart)
quakesTW <- quakes[-1]

saveRDS(quakesTW, "C:/ApplicationInR/quakesTW/data/quakesTW.rds")
