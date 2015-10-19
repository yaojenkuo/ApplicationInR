# Load required libraries
packageNames <- c("plyr", "ggplot2", "maptools", "leafletR", "geojsonio", "rgeos")
lapply(packageNames, library, character.only=TRUE)

# Read shapefile and csv data
setwd("C:/TWN_adm")
shpTW <- readShapeSpatial("TWN_adm2.shp")
dropJH <- read.csv("dropJH2013.csv", stringsAsFactors=FALSE)

# Simplifying the shapefile. To avoid very large GeoJSON files it is necessary to do a simplifying of the shapefile. Therefore, the R-package rgeos can be used.
shpTWSimply <- gSimplify(shpTW, tol=0.1, topologyPreserve=TRUE)

# Adjust shapefile
shpTW2 <- fortify(shpTWSimply, region = "NAME_2")
shpTW2$id[shpTW2$id=='Kaohsiung'] <- 'Kaohsiung City'
shpTW2$id[shpTW2$id=='Taichung'] <- 'Taichung City'
shpTW2$id[shpTW2$id=='Tainan'] <- 'Tainan City'

# Average drop rate in dropJH
dropJHAvg <- ddply(dropJH, .(county), summarize, dropRate = mean(dropJH))

# Merge shpTW2 and dropJHAvg
integratedData <- merge(shpTW2, dropJHAvg, by.x="id", by.y="county")

# Convert dataframe file to GeoJSON
geojson_write(integratedData, file = 'C:/TWN_adm/counties.geojson')

# Remember to add: var twnCountyDropRate = at the beginning of twnCountyDropRate.geojson