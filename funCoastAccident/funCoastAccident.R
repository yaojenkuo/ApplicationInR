# Accidents of Formosa Fun Coast

# Data Manipulation
setwd("C:/ApplicationInR/funCoastAccident")
Sys.setlocale(category = "LC_ALL", locale = "cht")#csv檔是繁體中文
accidentList <- read.csv("data/funCoastAccident.csv", header=TRUE, sep=",", row.names="編號", colClasses=c("character", "character", "character", "character", "character", "integer", "character", "character"), na.strings=c(''))
colnames(accidentList) <- c("county", "hospital", "gender", "nationality", "age", "woundType1", "woundType2")
accidentList$woundType1[is.na(accidentList$woundType1)] <- '不詳'
accidentList$woundType2[is.na(accidentList$woundType2)] <- '不詳'
accidentList$woundType1 <- factor(accidentList$woundType1, order=TRUE, levels=c("檢傷四級", "檢傷三級", "檢傷二級", "檢傷一級", "不詳"))
accidentList$woundType2 <- factor(accidentList$woundType2, order=TRUE, levels=c("輕傷", "中傷", "重傷", "不詳"))
saveRDS(accidentList, "data/accidentList.rds")