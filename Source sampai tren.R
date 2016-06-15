#Library yang dibutuhkan
library(ggplot2)
library(readr)
library(dplyr)

#Memasukan data ke dalam
train <- read.csv("train.csv", header = TRUE)
test <- read.csv("test.csv", header = TRUE)

#Menggabungkaan kedua dataset (menyamakan jumlah variabel terlebih dahulu)
train.new <- data.frame(Id = rep("None", nrow(train)), train[,])
test.Category <- data.frame(Category = rep("None", nrow(test)), test[,])
test.Descript <- data.frame(Descript = rep("None", nrow(test.Category)), test.Category[,])
test.new <- data.frame(Resolution = rep("None", nrow(test.Descript)), test.Descript[,])

data.combined <- rbind(test.new, train.new)

#Memprediksi kategori kejahatan yang ada dengan melihat isi kategori pada dataset train
unique(as.character(train$Category))

#Menampilkan peta wilayah semua kejahatan di San Fransisco


#Tren Kejahatan di San Fransisco secara Keseluruhan

#Menampilkan banyaknya kejahatan di San Fransisco perkategori pada console
sort(table(train$Category), decreasing = TRUE)

#Menampilkan histogram kejahatan di San Fransisco
train %>% 
  ggplot(aes(x = Category)) +
  geom_bar() +
  ggtitle("Banyaknya Kejahatan di San Fransisco Perkategori") +
  ylab("Banyak Kejahatan") +
  xlab("Kategori Kejahatan") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

#Menampilkan histogram banyaknya kejahatan di San Fransisco perkategori perhari 
train %>%
  ggplot(aes(x = factor(DayOfWeek, levels=c('Monday', 'Tuesday',
                                            'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday')))) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Perhari") +
  xlab("Hari") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")

#Menampilkan histogram banyaknya kejahatan di San Fransisco perkategori perdistrik 
train %>%
  ggplot(aes(x = PdDistrict)) +
  geom_bar(aes(fill=factor(Category))) +
  ggtitle("Tren Kejahatan di San Fransisco Perdistrik") +
  xlab("Distrik Kepolisian") +
  ylab("Banyaknya Kejahatan") +
  labs(fill = "Kategori")
    
#Menampilkan histogram banyaknya kejahatan di San Fransisco perkategori perbulan 
  