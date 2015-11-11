# Manipulate Original Dataset
library(chron)
quakesTW <- read.csv("C:/ApplicationInR/quakesTW/data/quakesTW.csv", stringsAsFactors=F)
colnames(quakesTW)[1] <- "datetime"
datetimeSplit <- strsplit(quakesTW$datetime, split=' ')# Split datetime to date & time
datePart <- c()
timePart <- c()
for (index in c(1:length(datetimeSplit))){
  datePart[index] <- datetimeSplit[[index]][1]
  timePart[index] <- datetimeSplit[[index]][2]
}
# Transform variable types
datePartNew <- as.Date(datePart, "%m/%d/%Y")
timePartNew <- chron(times=timePart, format=c(times='h:m:s'))
quakes <- cbind(quakesTW, datePartNew, timePartNew)
colnames(quakes)[6:7] <- c("datePart", "timePart")
quakes$yearPart <- as.numeric(format(quakes$datePart, "%Y"))
quakes$dateTime <- paste(quakes$datePart, quakes$timePart)
quakesTW <- quakes[-1]
# Output to .rds data type
saveRDS(quakesTW, "C:/ApplicationInR/quakesTW/data/quakesTW.rds")
