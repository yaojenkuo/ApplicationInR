library(jsonlite)
library(stringr)
path <- "https://storage.googleapis.com/py_ds_basic/countries.json"

# Split JSON data
countries_df <- fromJSON(path)
name_df <- countries_df$name
name_vector <- name_df[, 1]
latlng_list <- countries_df$latlng
latlng_vector <- rep(NA, times = length(latlng_list))

for (i in 1:length(latlng_list)) {
  if (length(latlng_list[[i]]) == 0) {
    latlng_vector[i] <- "NA NA"
  } else {
    latlng_vector[i] <- paste(as.character(latlng_list[[i]]), collapse = " ")
  }
}

lat_vector <- rep(NA, times = length(latlng_vector))
lng_vector <- rep(NA, times = length(latlng_vector))

for (i in 1:length(latlng_vector)) {
  lat_vector[i] <- as.numeric(strsplit(latlng_vector, split = " ")[[i]][1])
  lng_vector[i] <- as.numeric(strsplit(latlng_vector, split = " ")[[i]][2])
}

# Create final data frame
countries_df_from_json <- data.frame(name = name_vector, lat = lat_vector, lng = lng_vector)