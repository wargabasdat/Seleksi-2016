# Dataset yang sudah diimpor dinamakan 'Dataset'

# Analisis persoalan 1a (wanita).

# Melihat apakah intellegensi menjadi ketertarikan untuk perempuan.
# Cara pertama : melihat rata-rata dari 6 atribut, yaitu "intel","attr","sinc","fun","amb","shar" dari
#                data perempuan yang match (gender == 0, match == 1), dan NoMatch (gender == 0, match == 0)

DatasetMatch <- subset(Dataset, match == 1)
DatasetNoMatch <- subset(Dataset, match == 0)

DatasetMatchGender0 <- subset(DatasetMatch, gender == 0)
mean(DatasetMatchGender0$intel, na.rm = TRUE)
mean(DatasetMatchGender0$attr, na.rm = TRUE)
mean(DatasetMatchGender0$sinc, na.rm = TRUE)
mean(DatasetMatchGender0$fun, na.rm = TRUE)
mean(DatasetMatchGender0$amb, na.rm = TRUE)
mean(DatasetMatchGender0$shar, na.rm = TRUE)

DatasetNoMatchGender0 <- subset(DatasetNoMatch, gender == 0)
mean(DatasetNoMatchGender0$intel, na.rm = TRUE)
mean(DatasetNoMatchGender0$attr, na.rm = TRUE)
mean(DatasetNoMatchGender0$sinc, na.rm = TRUE)
mean(DatasetNoMatchGender0$fun, na.rm = TRUE)
mean(DatasetNoMatchGender0$amb, na.rm = TRUE)
mean(DatasetNoMatchGender0$shar, na.rm = TRUE)


# VISUALISASI
# ------------------------------------------
v1_1 <- mean(DatasetMatchGender0$intel, na.rm = TRUE)
v1_2 <- mean(DatasetMatchGender0$attr, na.rm = TRUE)
v1_3 <- mean(DatasetMatchGender0$sinc, na.rm = TRUE)
v1_4 <- mean(DatasetMatchGender0$fun, na.rm = TRUE)
v1_5 <- mean(DatasetMatchGender0$amb, na.rm = TRUE)
v1_6 <- mean(DatasetMatchGender0$shar, na.rm = TRUE)

Tabel1 = data.frame(Atribut=c("Intel","Attr","Sinc","Fun","Amb","Shar"), 
                    Mean=c(v1_1,v1_2,v1_3,v1_4, v1_5, v1_6))
Hist1 <-gvisBarChart(Tabel1, option = 
                       list(width = 500, height = 500, 
                       title = "Rata-rata keenam atribut dari DatasetMatchGender0"))
plot(Hist1)

v2_1 <- mean(DatasetNoMatchGender0$intel, na.rm = TRUE)
v2_2 <- mean(DatasetNoMatchGender0$attr, na.rm = TRUE)
v2_3 <- mean(DatasetNoMatchGender0$sinc, na.rm = TRUE)
v2_4 <- mean(DatasetNoMatchGender0$fun, na.rm = TRUE)
v2_5 <- mean(DatasetNoMatchGender0$amb, na.rm = TRUE)
v2_6 <- mean(DatasetNoMatchGender0$shar, na.rm = TRUE)

Tabel2 = data.frame(Atribut=c("Intel","Attr","Sinc","Fun","Amb","Shar"), 
                    Mean=c(v2_1,v2_2,v2_3,v2_4, v2_5, v2_6))
Hist2 <-gvisBarChart(Tabel2, option = 
                       list(width = 500, height = 500, 
                            title = "Rata-rata keenam atribut dari DatasetNoMatchGender0"))
plot(Hist2)
# ------------------------------------------


# Cara kedua : melihat rata-rata-rata ketertarikan dari DatasetMatchGender0, yaitu 
    # - pada saat SIGN-UP (1_1)
    # - pada saat DI TENGAH-TENGAH EVENT (1_s)
    # - pada saat FOLLOW-UP pertama (1_2)
    # - pada saat FOLLOW-UP kedua (1_3)

# 1_1
v3_1 <-mean(DatasetGender0$intel1_1, na.rm = TRUE)
v3_2 <-mean(DatasetGender0$attr1_1, na.rm = TRUE)
v3_3 <-mean(DatasetGender0$sinc1_1, na.rm = TRUE)
v3_4 <-mean(DatasetGender0$fun1_1, na.rm = TRUE)
v3_5 <-mean(DatasetGender0$amb1_1, na.rm = TRUE)
v3_6 <-mean(DatasetGender0$shar1_1, na.rm = TRUE)

# 1_s
v4_1 <-mean(DatasetGender0$intel1_s, na.rm = TRUE)
v4_2 <-mean(DatasetGender0$attr1_s, na.rm = TRUE)
v4_3 <-mean(DatasetGender0$sinc1_s, na.rm = TRUE)
v4_4 <-mean(DatasetGender0$fun1_s, na.rm = TRUE)
v4_5 <-mean(DatasetGender0$amb1_s, na.rm = TRUE)
v4_6 <-mean(DatasetGender0$shar1_s, na.rm = TRUE)

# 1_2
v5_1 <-mean(DatasetGender0$intel1_2, na.rm = TRUE)
v5_2 <-mean(DatasetGender0$attr1_2, na.rm = TRUE)
v5_3 <-mean(DatasetGender0$sinc1_2, na.rm = TRUE)
v5_4 <-mean(DatasetGender0$fun1_2, na.rm = TRUE)
v5_5 <-mean(DatasetGender0$amb1_2, na.rm = TRUE)
v5_6 <-mean(DatasetGender0$shar1_2, na.rm = TRUE)

# 1_3
v6_1 <-mean(DatasetGender0$intel1_3, na.rm = TRUE)
v6_2 <-mean(DatasetGender0$attr1_3, na.rm = TRUE)
v6_3 <-mean(DatasetGender0$sinc1_3, na.rm = TRUE)
v6_4 <-mean(DatasetGender0$fun1_3, na.rm = TRUE)
v6_5 <-mean(DatasetGender0$amb1_3, na.rm = TRUE)
v6_6 <-mean(DatasetGender0$shar1_3, na.rm = TRUE)


# VISUALISASI
Tabel3 =data.frame(Atribut=c("BEFORE_EVENT", "DURING_EVENT", "FOLLOW_UP1","FOLLOW_UP2"), 
              Intel=c(v3_1,v4_1,v5_1,v6_1), 
              Attr=c(v3_2,v4_2,v5_2,v6_2), 
              Sinc=c(v3_3,v4_3,v5_3,v6_3), 
              Fun=c(v3_4,v4_4,v5_4,v6_4),
              Amb=c(v3_5,v4_5,v5_5,v6_5),
              Shar=c(v3_6,v4_6,v5_6,v6_6))
Line3 <- gvisLineChart(Tabel3, option = 
                       list(width = 900, height = 500, 
                            title = "Ketertarikan Perempuan Pada Laki-laki (gender = 0)"))
plot(Line3)
# Cara ketiga : melihat korelasi antara match dan like
#               dengan 6 atribut yaitu "intel","attr","sinc","fun","amb","shar"

corelation1_1 <- cor(DatasetGender0[c("like","intel","attr","sinc","fun","amb","shar")], use="complete")
corelation1_2 <-cor(DatasetGender0[c("match","intel","attr","sinc","fun","amb","shar")], use="complete")

# VISUALISASI
corrplot(corelation1_1, method = c("number"), type="lower")
corrplot(corelation1_2, method = c("number"), type="lower")








# Kesimpulan dari tiga analisis di atas.
# Intelegensi tidak menjadi daya tarik perhatian utama untuk wanita. Justru, dari cara ketiga, dapat dikatakan
# bahwa faktor fun menjadi daya tarik utama karena memiliki nilai korelasi paling besar diantara 6 atribut tersebut.
# (Menjawab persoalan kedua untuk wanita)

# Analisis persoalan 1b (pria).

# Melihat apakah intellegensi menjadi ketertarikan untuk laki-laki
# Cara pertama : melihat rata-rata dari 6 atribut, yaitu "intel","attr","sinc","fun","amb","shar" dari
#                data perempuan yang match (gender == 0, match == 1), dan NoMatch (gender == 0, match == 0)


DatasetMatchGender1 <- subset(DatasetMatch, gender == 1)
v7_1 <- mean(DatasetMatchGender1$intel, na.rm = TRUE)
v7_2 <- mean(DatasetMatchGender1$attr, na.rm = TRUE)
v7_3 <- mean(DatasetMatchGender1$sinc, na.rm = TRUE)
v7_4 <- mean(DatasetMatchGender1$fun, na.rm = TRUE)
v7_5 <- mean(DatasetMatchGender1$amb, na.rm = TRUE)
v7_6 <- mean(DatasetMatchGender1$attr, na.rm = TRUE)

DatasetNoMatchGender1 <- subset(DatasetNoMatch, gender == 1)
v8_1 <- mean(DatasetNoMatchGender1$intel, na.rm = TRUE)
v8_2 <- mean(DatasetNoMatchGender1$attr, na.rm = TRUE)
v8_3 <- mean(DatasetNoMatchGender1$sinc, na.rm = TRUE)
v8_4 <- mean(DatasetNoMatchGender1$fun, na.rm = TRUE)
v8_5 <- mean(DatasetNoMatchGender1$amb, na.rm = TRUE)
v8_6 <- mean(DatasetNoMatchGender1$attr, na.rm = TRUE)

# VISUALISASI 
# ------------------------------------------

Tabel4 = data.frame(Atribut=c("Intel","Attr","Sinc","Fun","Amb","Shar"), 
                    Mean=c(v7_1,v7_2,v7_3,v7_4, v7_5, v7_6))
Hist3 <-gvisBarChart(Tabel4, option = 
                       list(width = 500, height = 500, 
                            title = "Rata-rata keenam atribut dari DatasetMatchGender1"))
plot(Hist3)


Tabel5 = data.frame(Atribut=c("Intel","Attr","Sinc","Fun","Amb","Shar"), 
                    Mean=c(v8_1,v8_2,v8_3,v8_4, v8_5, v8_6))
Hist4 <-gvisBarChart(Tabel5, option = 
                       list(width = 500, height = 500, 
                            title = "Rata-rata keenam atribut dari DatasetNoMatchGender1"))
plot(Hist4)
# ------------------------------------------

# Cara kedua : melihat rata-rata-rata ketertarikan dari DatasetMatchGender1, yaitu 
# - pada saat SIGN-UP (1_1)
# - pada saat FOLLOW-UP pertama (1_2)
# - pada saat FOLLOW-UP kedua (1_3)

# 1_1
v9_1 <-mean(DatasetGender1$intel1_1, na.rm = TRUE)
v9_2 <-mean(DatasetGender1$attr1_1, na.rm = TRUE)
v9_3 <-mean(DatasetGender1$sinc1_1, na.rm = TRUE)
v9_4 <-mean(DatasetGender1$fun1_1, na.rm = TRUE)
v9_5 <-mean(DatasetGender1$amb1_1, na.rm = TRUE)
v9_6 <-mean(DatasetGender1$shar1_1, na.rm = TRUE)

# 1_s
v10_1 <-mean(DatasetGender1$intel1_s, na.rm = TRUE)
v10_2 <-mean(DatasetGender1$attr1_s, na.rm = TRUE)
v10_3 <-mean(DatasetGender1$sinc1_s, na.rm = TRUE)
v10_4 <-mean(DatasetGender1$fun1_s, na.rm = TRUE)
v10_5 <-mean(DatasetGender1$amb1_s, na.rm = TRUE)
v10_6 <-mean(DatasetGender1$shar1_s, na.rm = TRUE)

# 1_2
v11_1 <-mean(DatasetGender1$intel1_2, na.rm = TRUE)
v11_2 <-mean(DatasetGender1$attr1_2, na.rm = TRUE)
v11_3 <-mean(DatasetGender1$sinc1_2, na.rm = TRUE)
v11_4 <-mean(DatasetGender1$fun1_2, na.rm = TRUE)
v11_5 <-mean(DatasetGender1$amb1_2, na.rm = TRUE)
v11_6 <-mean(DatasetGender1$shar1_2, na.rm = TRUE)

# 1_3
v12_1 <-mean(DatasetGender1$intel1_3, na.rm = TRUE)
v12_2 <-mean(DatasetGender1$attr1_3, na.rm = TRUE)
v12_3 <-mean(DatasetGender1$sinc1_3, na.rm = TRUE)
v12_4 <-mean(DatasetGender1$fun1_3, na.rm = TRUE)
v12_5 <-mean(DatasetGender1$amb1_3, na.rm = TRUE)
v12_6 <-mean(DatasetGender1$shar1_3, na.rm = TRUE)

# VISUALISASI
Tabel6 =data.frame(Atribut=c("BEFORE_EVENT", "DURING_EVENT", "FOLLOW_UP1","FOLLOW_UP2"), 
                   Intel=c(v9_1,v10_1,v11_1,v12_1), 
                   Attr=c(v9_2,v10_2,v11_2,v12_2), 
                   Sinc=c(v9_3,v10_3,v11_3,v12_3), 
                   Fun=c(v9_4,v10_4,v11_4,v12_4),
                   Amb=c(v9_5,v10_5,v11_5,v12_5),
                   Shar=c(v9_6,v10_6,v11_6,v12_6))
Line3 <- gvisLineChart(Tabel6, option = 
                         list(width = 900, height = 500, 
                              title = "Ketertarikan Laki-laki Pada Perempuan (gender = 1)"))
plot(Line3)



# Cara ketiga : melihat korelasi antara match dan like
#               dengan 6 atribut yaitu "intel","attr","sinc","fun","amb","shar"
  
corelation2_1 <- cor(DatasetGender1[c("like","intel","attr","sinc","fun","amb","shar")], use="complete")
corelation2_2 <-cor(DatasetGender1[c("match","intel","attr","sinc","fun","amb","shar")], use="complete")
  
# VISUALISASI
corrplot(corelation2_1, method = c("number"), type="lower")
corrplot(corelation2_2, method = c("number"), type="lower")


# Kesimpulan dari tiga analisis di atas.
# Attractive bisa dikatakan menjadi salah satu faktor dominan. Meskipun pada analisis pertama hal 
# tersebut tidak terlalu terlihat, namun hal itu terlihat pada analisis kedua, bahwa nilai attr selalu 
# lebih besar dari kelima nilai lainnya.
# Selain itu, pada analisis ketiga, nilai korelasi attr dengan match dan like juga lebih besar 
# dibandingkan nilai yang lain. Oleh karena itu, dapat dikatakan Attractive adalah salah satu faktor dominan.


# Untuk Analisis persoalan kedua, akan dilihat tabel korelasi dari analisis 1a dan 1b.

# Analisis 2a : Mencari satu faktor dominan lain untuk wanita
# Visualisasi
corrplot(corelation1_1, method = c("number"), type="lower")
corrplot(corelation1_2, method = c("number"), type="lower")


# Analisis 2b : Mencari satu faktor dominan lain untuk pria
# Visualisasi

corrplot(corelation2_1, method = c("number"), type="lower")
corrplot(corelation2_2, method = c("number"), type="lower")
