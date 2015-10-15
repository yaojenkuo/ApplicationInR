# Download the shapefile of the countries and census data from UN.
# http://www.naturalearthdata.com/ (for Shapefile)
# http://data.un.org/ (for gender ratio census data)

# Set working library
setwd("C:/ApplicationInR/worldGenderRatio")
# Load required packages
library(rgdal) # to read Shapefile
library(rgeos) # to simplify Shapefile
library(geojsonio) # to write GeoJSON

# Read Shapefile of countries from C:/ApplicationInR/worldGenderRatio/countries
countryShp <- readOGR('countries', 'ne_10m_admin_0_countries')

# Read csv file of census data from C:/ApplicationInR/worldGenderRatio/data
unData <- read.csv('data/UN_Gender-Relations.csv', head=T, sep=';')

# Integrate all required informations in a data frame
countryShpData <- countryShp@data[,c('WOE_ID','NAME_LONG')]
rownames(unData) <- rownames(countryShpData)
integratedData <- cbind(countryShpData,unData[,2])

# Replace missing values with ' '
integratedData[which(is.na(integratedData[,3])==TRUE) ,3] <- ' '

# Shown text on hover
textOnHover <- c()
textOnHover[which(integratedData[,3]==' ')] <- 'No data provided by UN'
textOnHover[which(integratedData[,3]!=' ')] <- 'women per 100 men'
integratedData <- cbind(integratedData,textOnHover)

# Column names of integratedData
colnames(integratedData)=c('WOE_ID','COUNTRY','SEX_RATIO','TEXT_ON_HOVER')

# Transform SEX_RATIO into numeric
integratedData$SEX_RATIO <- as.numeric(integratedData$SEX_RATIO)

# Simplify Shapefile
countryShpSimplified<-gSimplify(countryShp,tol=0.1, topologyPreserve=TRUE)

# Transform into SpatialPolygonsDataFrame
spdf=SpatialPolygonsDataFrame(countryShpSimplified, data=integratedData)

# Write GeoJSON
geojson_write(spdf, file = 'C:/ApplicationInR/worldGenderRatio/geojson/countries.geojson')