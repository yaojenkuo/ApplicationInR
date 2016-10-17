# read packages
packages <- c("geoR", "ggplot2", "RColorBrewer", "gstat", "sp", "rgeos", "maptools")
sapply(packages, FUN = library, character.only = TRUE)

# preparing data

prepare.data <- function(data_path){
  input_data <- read.csv(paste(data_path, "test.csv", sep = ''))
  input_data <- input_data[, -1]
  #input_data <- as.geodata(input_data, coords.col = 1:2, data.col = 3)
  return(input_data)
}

test_data <- prepare.data("C:/Users/ASUS/Downloads/")#switch to your own path

coordinates(test_data) <- ~lon+lat
x.range <- as.integer(range(test_data@coords[,1])) + c(1L, 2L)
y.range <- as.integer(range(test_data@coords[,2])) + c(-1L, 1L)

# create predicted values
grd <- expand.grid(x=seq(from=x.range[1], to=x.range[2], by=0.01), y=seq(from=y.range[1], to=y.range[2], by=0.01))
coordinates(grd) <- ~ x + y
gridded(grd) <- TRUE
idw <- idw(formula=pm25 ~ 1, locations=test_data, newdata=grd)
idw.output <- as.data.frame(idw)
names(idw.output)[1:3] <- c("long","lat","pm25")
boroughs <- readShapePoly("C:/Users/ASUS/Downloads/TWN_adm2.shp")#switch to your own path
boroughoutline <- fortify(boroughs, region="NAME_2")

# plotting
plot<-ggplot(data=idw.output,aes(x=long,y=lat))#start with the base-plot 
layer1<-c(geom_tile(data=idw.output,aes(fill=pm25)))#then create a tile layer and fill with predicted values
layer2<-c(geom_path(data=boroughoutline,aes(long, lat, group=group),colour = "grey40", size=1))#then create an outline layer
# now add all of the data together
plot+layer1+layer2+scale_fill_gradient(low="#FEEBE2", high="#7A0177")+coord_equal()
