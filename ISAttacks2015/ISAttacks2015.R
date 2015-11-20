#Islamic State Attacks in 2015
#Source: BBC

# Preparing the data from BBC
date <- c('2015-11-13', '2015-11-12', '2015-10-31', '2015-10-10', '2015-07-18', '2015-06-26', '2015-06-26', '2015-05-22', '2015-03-21')
country <- c('France', 'Lebanon', 'Egypt', 'Turkey', 'Tunisia', 'Iraq', 'Kuwait', 'Saudi Arabia', 'Yemen')
state <- c('Paris', 'Beirut', 'Janub Sina\'', 'Ankara', 'Sousse', 'Diyala', 'Al Asimah', 'Ash Sharqiyah', 'Sana\'a')
city <- c('Paris', 'Beirut', 'Sharm el Sheikh', 'Ankara', 'Sousse', 'Khan Bani Saad', 'Kuwait City', 'Qatif', 'Sana\'a')
deaths <- c(129, 43, 224, 102, 38, 125, 27, 21, 137)
ISAttacks2015 <- data.frame(date, country, state, city, deaths, stringsAsFactors=FALSE)
ISAttacks2015$date <- as.Date(ISAttacks2015$date, "%Y-%m-%d")#Y for 4-digit

setwd("C:/ApplicationInR/ISAttacks2015/states")
# Load required packages
library(rgdal) # to read Shapefile
library(rgeos) # to simplify Shapefile
library(geojsonio) # to write GeoJSON
library(maptools) # to read Shapefile
# Read Shapefile of states from C:/ApplicationInR/ISAttacks2015/states
stateShp <- readShapePoly('ne_10m_admin_0_countries.shp')
# Subset Shapefile with attacked states
stateShpSubset <- stateShp[stateShp$NAME %in% c('France', 'Lebanon', 'Egypt', 'Turkey', 'Tunisia', 'Iraq', 'Kuwait', 'Saudi Arabia', 'Yemen'),]
# Delete an error
#stateShpSubsetCorrection <- stateShpSubset[stateShpSubset$woe_id!=2345236, ]
# Simplify attacked states
stateShpSimplify <- gSimplify(stateShpSubset,tol=0.005, topologyPreserve=TRUE)

stateShpData <- stateShpSubset@data[,c('NAME', 'WOE_ID')]
#stateShpDataCorrection <- stateShpData[stateShpData$woe_id!=2345236, ]#Delete an error observation
stateShpDataOrder <- stateShpData[order(stateShpData$NAME),]#Sort
ISAttacks2015Order <- ISAttacks2015[order(ISAttacks2015$country),]#Sort
rownames(ISAttacks2015Order) <- rownames(stateShpDataOrder)#Very important!
stateShpDataOrder <- cbind(stateShpDataOrder, ISAttacks2015Order[,c(1,3,4,5)])#Merge
colnames(stateShpDataOrder)[1] <- c('country')#Change column name
# SpatialPolygonsDataFrame is created to write the GeoJSON file
ISAttackSPDF <- SpatialPolygonsDataFrame(stateShpSimplify, data=stateShpDataOrder)
# Create GeoJSON
writeOGR(ISAttackSPDF, 'C:/ApplicationInR/ISAttacks2015/ISAttacksStates2015.js', layer="", driver="GeoJSON")