#Library yang dibutuhkan
library(ggplot2)
library(readr)
library(dplyr)
library(RColorBrewer)
library(leaflet)

#Memasukan data ke dalam
train <- read.csv("train.csv", header = TRUE)
test <- read.csv("test.csv", header = TRUE)

#Menggabungkaan kedua dataset (menyamakan jumlah variabel terlebih dahulu)
train.new <- data.frame(Id = rep("None", nrow(train)), train[,])
test.Category <- data.frame(Category = rep("None", nrow(test)), test[,])
test.Descript <- data.frame(Descript = rep("None", nrow(test.Category)), test.Category[,])
test.new <- data.frame(Resolution = rep("None", nrow(test.Descript)), test.Descript[,])

data.combined <- rbind(test.new, train.new)

#Menambahkan kolum street corner pada kedua dataset
train$StreetCorner = "No"
train[which(grepl( '/',train$Address)),'StreetCorner']="Yes"

test$StreetCorner = "No"
test[which(grepl( '/',train$Address)),'StreetCorner']="Yes"

#Memprediksi kategori kejahatan yang ada dengan melihat isi kategori pada dataset train
unique(as.character(train$Category[which(train$StreetCorner == "Yes")]))

#Mengambil Data Kejahatan yang Terjadi di Ujung Jalan
train.streetcorner <- train[which(train$StreetCorner == "Yes"),]
test.streetcorner <- test[which(test$StreetCorner == "Yes"),]

#Menampilkan peta wilayah semua kejahatan di San Fransisco
trains.map <- function(categories, n) {
  
  new.train <- filter(train.streetcorner, Category %in% categories) %>% droplevels() 
  
  pal <- colorFactor(brewer.pal(length(unique(new.train$Category)), "Set3"),  
                     domain = new.train$Category)
  
  leaflet(new.train[1:n,]) %>% 
    addProviderTiles("CartoDB.Positron") %>% 
    addCircleMarkers (lng =  ~X, lat =  ~Y, 
                      color = ~pal(Category),
                      opacity = .7, radius  = 1) %>%  
    addLegend(pal = pal, values = new.train$Category)
}

trains.map(c("WARRANTS", "OTHER OFFENSES", "LARCENY/THEFT", "VEHICLE THEFT", 
             "VANDALISM", "NON-CRIMINAL", "ROBBERY", "ASSAULT", "WEAPON LAWS", 
             "BURGLARY", "SUSPICIOUS OCC", "DRUNKENNESS", 
             "FORGERY/COUNTERFEITING", "DRUG/NARCOTIC", "STOLEN PROPERTY", 
             "SECONDARY CODES", "TRESPASS", "MISSING PERSON", "FRAUD", 
             "KIDNAPPING", "RUNAWAY", "DRIVING UNDER THE INFLUENCE", 
             "SEX OFFENSES FORCIBLE", "PROSTITUTION", "DISORDERLY CONDUCT", 
             "ARSON", "FAMILY OFFENSES", "LIQUOR LAWS", "BRIBERY", 
             "EMBEZZLEMENT", "SUICIDE", "LOITERING", "SEX OFFENSES NON FORCIBLE", 
             "EXTORTION", "GAMBLING", "BAD CHECKS", "RECOVERED VEHICLE"
             , "PORNOGRAPHY/OBSCENE MAT"), n = nrow(train.streetcorner))

#Tren Kejahatan di San Fransisco secara Keseluruhan

#Menampilkan banyaknya kejahatan di San Fransisco perkategori pada console
sort(table(train.streetcorner$Category), decreasing = TRUE)

#Menampilkan histogram kejahatan di San Fransisco
train.streetcorner %>% 
  ggplot(aes(x = Category)) +
  geom_bar() +
  ggtitle("Banyaknya Kejahatan di San Fransisco Perkategori") +
  ylab("Banyak Kejahatan") +
  xlab("Kategori Kejahatan") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Menampilkan histogram banyaknya kejahatan di San Fransisco perkategori perhari 
train.streetcorner %>%
  ggplot(aes(x = factor(DayOfWeek, levels=c('Monday', 'Tuesday',
                                            'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')))) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Perhari") +
  xlab("Hari") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")

#Menampilkan banyaknya kejahatan di San Fransisco perkategori perhari 
sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Monday")]), decreasing = TRUE)

#Menampilkan histogram banyaknya kejahatan di San Fransisco perkategori perdistrik 
train.streetcorner %>%
  ggplot(aes(x = PdDistrict)) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Perdistrik") +
  xlab("Distrik Kepolisian") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")

#Menampilkan banyaknya kejahatan di San Fransisco perkategori perhari 
sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "TENDERLOIN")]), decreasing = TRUE)


#Menampilkan histogram banyaknya kejahatan di San Fransisco perkategori perbulan

#Menambahkan kolom Collar Crime berdasarkan kategori yang ada

train.streetcorner$CollarCrime = "other"
train.streetcorner[which(train.streetcorner$Category=="FRAUD"),'CollarCrime'] = "white"
train.streetcorner[which(train.streetcorner$Category=="BAD CHECKS"),'CollarCrime'] = "white"
train.streetcorner[which(train.streetcorner$Category=="FORGERY/COUNTERFEITING"),'CollarCrime'] = "white"
train.streetcorner[which(train.streetcorner$Category=="EXTORTION"),'CollarCrime'] = "white"
train.streetcorner[which(train.streetcorner$Category=="EMBEZZLEMENT"),'CollarCrime'] = "white"
train.streetcorner[which(train.streetcorner$Category=="SUSPICIOUS ACC"),'CollarCrime'] = "white"
train.streetcorner[which(train.streetcorner$Category=="BRIBERY"),'CollarCrime'] = "white"

train.streetcorner[which(train.streetcorner$Category=="VANDALISM"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="LARCENY/THEFT"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="STOLEN PROPERTY"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="ROBBERY"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="DRIVING UNDER THE INFLUENCE"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="DISORDERLY CONDUCT"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="LIQUOR LAWS"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="VEHICLE THEFT"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="ASSAULT"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="KIDNAPPING"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="TRESPASS"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="ARSON"),'CollarCrime'] = "blue"
train.streetcorner[which(train.streetcorner$Category=="RECOVERED VEHICLE"),'CollarCrime'] = "blue"