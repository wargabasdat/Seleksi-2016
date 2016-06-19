#Take Me Out Indonesia (kelompok 5)
#Dharma Kurnia Septialoka 13514028
#Joshua Atmadja 13514098

#Analisis ini menggunakan RStudio. CSV yang diberikan sudah diimport.
#Nama dari SpeedDatingData.csv dalam analisis ini ialah Dataset
Dataset <- read.csv("C:/Users/Joshua/Dropbox/IF2014/Calon Lab/Lab Basis Data/Tugas 2/Speed Dating Data.csv")

##Untuk analisis pembuktian pada soal no 1, akan dilakukan terlebih dahulu operasi subset
#Dataset kemudian dipisahkan dengan subset untuk mencari semua tupel yang memiliki nilai atribut match == 1 dan match == 0
dataMatch <- subset(Dataset, match==1)
dataNoMatch <- subset(Dataset, match==0)

#Dataset juga dipisahkan antara laki-laki dan perempuan
dataAllFemale <- subset(Dataset, gender==0)
dataAllMale <- subset(Dataset, gender==1)

#Dari subset dataMatch, pisahkan sesuai jenis kelamin
dataFemale <- subset(dataMatch, gender==0)
dataMale <- subset(dataMatch, gender==1)

#Nomor 1 memfokuskan pada dataFemale terhadap atribut attr, intel, sinc, fun, amb, shar.
#Analisis pertama dilakukan dengan mencari rata-rata dari enam atribut tersebut di atas.
intelMatch <- mean(dataFemale$intel, na.rm=TRUE)
attrMatch <- mean(dataFemale$attr, na.rm=TRUE)
sincMatch <- mean(dataFemale$sinc, na.rm=TRUE)
funMatch <- mean(dataFemale$fun, na.rm = TRUE)
ambMatch <- mean(dataFemale$amb, na.rm = TRUE)
sharMatch <- mean(dataFemale$shar, na.rm = TRUE)
matchTrait <- c(intelMatch, attrMatch, sincMatch, funMatch, ambMatch, sharMatch)

#Kemudian dicoba untuk mencari rata-rata dari enam atribut tersebut tetapi menggunakan dataNoMatch untuk perempuan
dataNoFemale <- subset(dataNoMatch, gender==0)
intelNoMatch <- mean(dataNoFemale$intel, na.rm=TRUE)
attrNoMatch <- mean(dataNoFemale$attr, na.rm=TRUE)
sincNoMatch <- mean(dataNoFemale$sinc, na.rm=TRUE)
funNoMatch <- mean(dataNoFemale$fun, na.rm = TRUE)
ambNoMatch <- mean(dataNoFemale$amb, na.rm = TRUE)
sharNoMatch <- mean(dataNoFemale$shar, na.rm = TRUE)
noMatchTrait <- c(intelNoMatch, attrNoMatch, sincNoMatch, funNoMatch, ambNoMatch, sharNoMatch)

#Visualisasi matchTrait
plot(matchTrait, type="o", col="blue", axes=F, ann=F)
axis(1, at=1:6, lab=c("intel","attr","sinc","fun","amb","shar"))
axis(2, las=1)
box()
title(main="Match Trait", col.main="blue", font.main=4)
title(xlab="Faktor", ylab="Rata-rata", col.lab="red")

#Visualisasi noMatchTrait
plot(noMatchTrait, type="o", col="blue", axes=F, ann=F)
axis(1, at=1:6, lab=c("intel","attr","sinc","fun","amb","shar"))
axis(2, las=1)
box()
title(main="Not Match Trait", col.main="blue", font.main=4)
title(xlab="Faktor", ylab="Rata-rata",col.lab="red")


##Analisis Kedua dengan melihat ketertarikan wanita kepada pria dari waktu ke waktu dari dataFemale
#1_1 ketika mendaftarkan diri
#1_2 ketika follow up pertama
#1_3 ketika follow up kedua

#label untuk visualisasi
timeLabel <- c("Sign up","Follow Up 1","Follow Up 2")

#1_1
intel11 <- mean(dataFemale$intel1_1, na.rm=TRUE)
attr11 <- mean(dataFemale$attr1_1, na.rm=TRUE)
sinc11 <- mean(dataFemale$sinc1_1, na.rm=TRUE)
fun11 <- mean(dataFemale$fun1_1, na.rm = TRUE)
amb11 <- mean(dataFemale$amb1_1, na.rm = TRUE)
shar11 <- mean(dataFemale$shar1_1, na.rm = TRUE)

#1_2
intel12 <- mean(dataFemale$intel1_2, na.rm=TRUE)
attr12 <- mean(dataFemale$attr1_2, na.rm=TRUE)
sinc12 <- mean(dataFemale$sinc1_2, na.rm=TRUE)
fun12 <- mean(dataFemale$fun1_2, na.rm = TRUE)
amb12 <- mean(dataFemale$amb1_2, na.rm = TRUE)
shar12 <- mean(dataFemale$shar1_2, na.rm = TRUE)

#1_3
intel13 <- mean(dataFemale$intel1_3, na.rm=TRUE)
attr13 <- mean(dataFemale$attr1_3, na.rm=TRUE)
sinc13 <- mean(dataFemale$sinc1_3, na.rm=TRUE)
fun13 <- mean(dataFemale$fun1_3, na.rm = TRUE)
amb13 <- mean(dataFemale$amb1_3, na.rm = TRUE)
shar13 <- mean(dataFemale$shar1_3, na.rm = TRUE)

#Merangkum masing-masing faktor
intelAll <- c(intel11, intel12, intel13)
attrAll <- c(attr11, attr12, attr13)
sincAll <- c(sinc11, sinc12, sinc13)
funAll <- c(fun11, fun12, fun13)
ambAll <- c(amb11, amb12, amb13)
sharAll <- c(shar11, shar12, shar13)

#visualisasi 1_1 s.d. 1_3
p_range<-range(0,intelAll,attrAll,sincAll,funAll,ambAll,sharAll)
plot(intelAll, type="o", col="blue", ylim=p_range, axes=FALSE, ann=F)
axis(1, at=1:3, lab=timeLabel)
axis(2, las=1)
box()
lines(attrAll, type="o", pch=22, lty=2, col="red")
lines(sincAll, type="o", pch=23, lty=3, col="forestgreen")
lines(funAll, type="o", pch=24, lty=4, col="yellow")
lines(ambAll, type="o", pch=25, lty=5, col="black")
lines(sharAll, type="o", pch=25, lty=6, col="orange")
title(main="Interest Time-by-Time", col.main="blue", font.main=4)
title(xlab="Waktu", ylab="Rata-rata", col.lab="red")
legendPlot <- c("intel","attr","sinc","fun","amb","shar")
legend("bottomright", c("intel","attr","sinc","fun","amb","shar"), col=c("blue","red","forestgreen","yellow","black","orange"), pch=21:25, lty=1:6,cex=0.8)

##Analisis Ketiga ialah dengan melihat korelasi dari semua faktor utama pada dataFemale
#Fungsi yang digunakan ialah cor() dan divisualisasikan dengan corrplot lewat package "corrplot"
cor1<-cor(dataAllFemale[c("match","intel","attr","sinc","fun","amb","shar")],use="complete") #dilihat korelasinya dengan atribut match
cor2<-cor(dataAllFemale[c("like","intel","attr","sinc","fun","amb","shar")],use="complete") #dilihat korelasinya dengan atribut like

#visualisasi matriks korelasi
corrplot(cor1, method="number")
corrplot(cor2, method="number")

##Dari tiga analisis di atas, kesimpulannya ialah bahwa wanita memang pada bawasannya tertarik pada intelejensi pria.
#Namun setelah mendapatkan pasangan, mereka lebih tertarik pada attractiveness dari pria.
