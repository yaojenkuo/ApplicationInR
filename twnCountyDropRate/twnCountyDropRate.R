# Load required libraries
packageNames <- c("plyr", "ggplot2", "maptools", "leafletR", "geojsonio", "rgeos", "rgdal")
lapply(packageNames, library, character.only=TRUE)

# Read shapefile and csv data
setwd("C:/TWN_adm")
shpTW <- readShapeSpatial("TWN_adm2.shp")
dropJH <- read.csv("dropJH2013.csv", stringsAsFactors=FALSE)

shpTW2 <- shpTW@data[,c('ID_2','NAME_2')]
shpTW2 <- shpTW2[order(shpTW2$NAME_2),]

# Simplifying the shapefile. To avoid very large GeoJSON files it is necessary to do a simplifying of the shapefile. Therefore, the R-package rgeos can be used.
shpTWSimply <- gSimplify(shpTW, tol=0.005, topologyPreserve=TRUE)

# Adjust shapefile
shpTW2$NAME_2[shpTW2$NAME_2=='Kaohsiung'] <- 'Kaohsiung City'
shpTW2$NAME_2[shpTW2$NAME_2=='Taichung'] <- 'Taichung City'
shpTW2$NAME_2[shpTW2$NAME_2=='Tainan'] <- 'Tainan City'

# Average drop rate in dropJH
dropJHAvg <- ddply(dropJH, .(county), summarize, dropRate = mean(dropJH))

# Merge shpTW2 and dropJHAvg
integratedData <- merge(shpTW2, dropJHAvg, by.x="NAME_2", by.y="county", all.x=TRUE)
rownames(integratedData) <- rownames(shpTW2)#Very important!

# Convert dataframe file to GeoJSON
spdf <- SpatialPolygonsDataFrame(shpTWSimply, data=integratedData)
writeOGR(spdf, 'counties.js', layer="", driver="GeoJSON")

# Remember to add: var twnCountyDropRate = at the beginning of counties.js