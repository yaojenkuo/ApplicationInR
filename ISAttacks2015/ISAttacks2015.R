#Islamic State Attacks in 2015
#Source: BBC

date <- c('2015-11-13', '2015-11-12', '2015-10-31', '2015-10-10', '2015-07-18', '2015-06-26', '2015-06-26', '2015-05-22', '2015-03-21','2015-03-18')
#country <- c('France', 'Lebanon', 'Egypt', 'Turkey', 'Tunisia', 'Iraq', 'Kuwait', 'Saudi Arabia', 'Yemen', 'Tunisia')
state <- c('Paris', 'Beirut', 'Janub Sina\'', 'Ankara', 'Sousse', 'Diyala', 'Al Asimah', 'Ash Sharqiyah', 'Sana\'a', 'Tunis')
city <- c('Paris', 'Beirut', 'Sharm el Sheikh', 'Ankara', 'Sousse', 'Khan Bani Saad', 'Kuwait City', 'Qatif', 'Sana\'a', 'Tunis City')
deaths <- c(129, 43, 224, 102, 38, 125, 27, 21, 137, 19)

ISAttacks2015 <- data.frame(date, state, city, deaths, stringsAsFactors=FALSE)
ISAttacks2015$date <- as.Date(ISAttacks2015$date, "%Y-%m-%d")#Y for 4-digit

setwd("C:/ApplicationInR/ISAttacks2015")
# Load required packages
library(rgdal) # to read Shapefile
library(rgeos) # to simplify Shapefile
library(geojsonio) # to write GeoJSON
library(maptools) # to read Shapefile
# Read Shapefile of states from C:/ApplicationInR/ISAttacks2015/states
stateShp <- readShapePoly('C:/ApplicationInR/ISAttacks2015/states/ne_10m_admin_1_states_provinces.shp')
stateShpSubset <- stateShp[stateShp$name %in% c('Paris', 'Beirut', 'Janub Sina\'', 'Ankara', 'Sousse', 'Diyala', 'Al Asimah', 'Ash Sharqiyah', 'Sana\'a', 'Tunis'),]
stateShpSimplify <- gSimplify(stateShpSubset,tol=0.005, topologyPreserve=TRUE)

stateShpSubset <- stateShpSubset[order(stateShpSubset$name),]

stateShpMerge <- merge(stateShpSubset, ISAttacks2015, by.x='name', by.y='state', all.x=T)

stateShpData <- stateShpMerge@data[,c("date", "city", "deaths")]

rownames(stateShpMerge) <- rownames(stateShpSubset)
stateSPDF <- SpatialPolygonsDataFrame(stateShpSimplify, data=stateShpMerge)
