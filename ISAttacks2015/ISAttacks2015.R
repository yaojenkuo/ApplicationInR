#Islamic State Attacks in 2015
#Source: BBC

date <- c('2015-11-13', '2015-11-12', '2015-10-31', '2015-10-10', '2015-07-18', '2015-06-26', '2015-06-26', '2015-05-22', '2015-03-21','2015-03-18')
country <- c('France', 'Lebanon', 'Egypt', 'Turkey', 'Tunisia', 'Iraq', 'Kuwait', 'Saudi Arabia', 'Yemen', 'Tunisia')
city <- c('Paris', 'Beirut', 'Sharm el Sheikh', 'Ankara', 'Sousse', 'Khan Bani Saad', 'Kuwait City', 'Qatif', 'Sana\'a', 'Tunis City')
deaths <- c(129, 43, 224, 102, 38, 125, 27, 21, 137, 19)

ISAttacks2015 <- data.frame(date, country, city, deaths, stringsAsFactors=FALSE)
ISAttacks2015$date <- as.Date(ISAttacks2015$date, "%Y-%m-%d")#Y for 4-digit

