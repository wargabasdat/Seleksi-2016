#SCRIPT DATA ANALYSIS DAN DATA VISUALIZATION KRIMINAL SAN FRANCISCO

#Library yang dibutuhkan
library(ggplot2)
library(readr)
library(dplyr)
library(RColorBrewer)
library(leaflet)
library(lubridate)

#Memasukan data ke dalam
train <- read.csv("train.csv", header = TRUE)
test <- read.csv("test.csv", header = TRUE)

#PREDIKSI KATEGORI KEJAHATAN DI UJUNG JALAN

#Menambahkan kolum street corner pada kedua dataset
train$StreetCorner = "No"
train[which(grepl( '/',train$Address)),'StreetCorner']="Yes"

test$StreetCorner = "No"
test[which(grepl( '/',train$Address)),'StreetCorner']="Yes"

#Memprediksi kategori kejahatan yang ada dengan melihat isi kategori pada dataset train
unique((train$Category[which(train$StreetCorner == "Yes")]))

#Mengambil Data Kejahatan yang Terjadi di Ujung Jalan
train.streetcorner <- train[which(train$StreetCorner == "Yes"),]
test.streetcorner <- test[which(test$StreetCorner == "Yes"),]

#Menampilkan peta wilayah semua kejahatan di San Francisco
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

#TREN KEJAHATAN DI UJUNG JALAN

#Menampilkan banyaknya kejahatan di San Francisco perkategori pada console
head(sort(table(train.streetcorner$Category), decreasing = TRUE))

#Menampilkan histogram kejahatan di San Francisco
train.streetcorner %>% 
  ggplot(aes(x = Category)) +
  geom_bar() +
  ggtitle("Banyaknya Kejahatan di San Francisco Perkategori") +
  ylab("Banyak Kejahatan") +
  xlab("Kategori Kejahatan") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Menampilkan histogram banyaknya kejahatan di San Francisco perhari dalam satu minggu
train.streetcorner %>%
  ggplot(aes(x = factor(DayOfWeek, levels=c('Monday', 'Tuesday',
                                            'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')))) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Perhari") +
  xlab("Hari") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")

#Menampilkan histogram banyaknya kejahatan di San Francisco perkategori untuk masing-masing hari
train.streetcorner$DayOfWeek <- factor(train.streetcorner$DayOfWeek, levels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
ggplot(data=train.streetcorner, aes(x=Category)) +
  geom_bar(colour="black", fill="skyblue") +
  xlab('Kategori') +
  ylab('Banyaknya Kejahatan') + 
  ggtitle("Tren Kejahatan di San Fransisco Perkategori untuk Masing-Masing Hari") +
  facet_wrap(~DayOfWeek) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Menampilkan tren kejahatan di San Francisco perkategori perhari dalam satu minggu pada console
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Monday")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Tuesday")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Wednesday")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Thursday")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Friday")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Saturday")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$DayOfWeek == "Sunday")]), decreasing = TRUE))

#Menampilkan histogram banyaknya kejahatan di San Francisco perdistrik 
train.streetcorner %>%
  ggplot(aes(x = PdDistrict)) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Perdistrik") +
  xlab("Distrik Kepolisian") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")

#Menampilkan histogram banyaknya kejahatan di San Francisco perkategori untuk masing-masing distrik
ggplot(data=train.streetcorner, aes(x=Category)) +
  geom_bar(colour="black", fill="magenta2") +
  xlab('Kategori') +
  ggtitle("Tren Kejahatan di San Fransisco Perkategori untuk Masing-Masing Distrik") +
  ylab('Banyaknya Kejahatan') + 
  facet_wrap(~PdDistrict) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Menampilkan banyaknya kejahatan di San Francisco perdistrik kepolisian pada console 
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "TENDERLOIN")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "BAYVIEW")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "CENTRAL")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "INGLESIDE")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "MISSION")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "NORTHERN")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "PARK")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "RICHMOND")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "SOUTHERN")]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$PdDistrict == "TARAVAL")]), decreasing = TRUE))

#Membuat kolom baru berupa tahun yang diambil dari tanggal
train.streetcorner$Year = year(train.streetcorner$Dates)
test.streetcorner$Year = year(test.streetcorner$Dates)

#Menampilkan histogram banyaknya kejahatan di San Francisco perkategori untuk masing-masing tahun
ggplot(data=train.streetcorner, aes(x=Category)) +
  geom_bar(colour="black", fill="springgreen") +
  xlab('Kategori') +
  ylab('Banyaknya Kejahatan') + 
  ggtitle("Tren Kejahatan di San Fransisco Perkategori untuk Masing-Masing Tahun") +
  facet_wrap(~Year) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Menampilkan histogram banyaknya kejahatan di San Francisco pertahun
train.streetcorner %>%
  ggplot(aes(x = Year)) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Pertahun") +
  xlab("Tahun") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")

#Menampilkan banyaknya kejahatan di San Francisco perdistrik kepolisian pada console 
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2003)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2004)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2005)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2006)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2007)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2008)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2009)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2010)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2011)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2012)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2013)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2014)]), decreasing = TRUE))
head(sort(table(train.streetcorner$Category[which(train.streetcorner$Year == 2015)]), decreasing = TRUE))

#MENGATEGORIKAN KATEGORI-KATEGORI KEJAHATAN (COLLAR-CRIME)

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

#Menampilkan histogram kelompok kejahatan di San Francisco
train.streetcorner %>% 
  ggplot(aes(x = factor(CollarCrime, levels=c('white', 'blue',
                                            'other')))) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Banyaknya Kejahatan di San Fransisco Perkelompok") +
  ylab("Banyak Kejahatan") +
  xlab("Collar Crime") 
