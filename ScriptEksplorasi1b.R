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

#Nomor 1 memfokuskan pada dataMale terhadap atribut attr, intel, sinc, fun, amb, shar.
#Analisis pertama dilakukan dengan mencari rata-rata dari enam atribut tersebut di atas.
intelMatch <- mean(dataMale$intel, na.rm=TRUE)
attrMatch <- mean(dataMale$attr, na.rm=TRUE)
sincMatch <- mean(dataMale$sinc, na.rm=TRUE)
funMatch <- mean(dataMale$fun, na.rm = TRUE)
ambMatch <- mean(dataMale$amb, na.rm = TRUE)
sharMatch <- mean(dataMale$shar, na.rm = TRUE)
matchTrait <- c(intelMatch, attrMatch, sincMatch, funMatch, ambMatch, sharMatch)

#Kemudian dicoba untuk mencari rata-rata dari enam atribut tersebut tetapi menggunakan dataNoMatch untuk laki-laki
dataNoMale <- subset(dataNoMatch, gender==1)
intelNoMatch <- mean(dataNoMale$intel, na.rm=TRUE)
attrNoMatch <- mean(dataNoMale$attr, na.rm=TRUE)
sincNoMatch <- mean(dataNoMale$sinc, na.rm=TRUE)
funNoMatch <- mean(dataNoMale$fun, na.rm = TRUE)
ambNoMatch <- mean(dataNoMale$amb, na.rm = TRUE)
sharNoMatch <- mean(dataNoMale$shar, na.rm = TRUE)
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


##Analisis Kedua dengan melihat ketertarikan pria kepada wanita dari waktu ke waktu dari dataMale
#1_1 ketika mendaftarkan diri
#1_2 ketika follow up pertama
#1_3 ketika follow up kedua

#label untuk visualisasi
timeLabel <- c("Sign up","Follow Up 1","Follow Up 2")

#1_1
intel11 <- mean(dataMale$intel1_1, na.rm=TRUE)
attr11 <- mean(dataMale$attr1_1, na.rm=TRUE)
sinc11 <- mean(dataMale$sinc1_1, na.rm=TRUE)
fun11 <- mean(dataMale$fun1_1, na.rm = TRUE)
amb11 <- mean(dataMale$amb1_1, na.rm = TRUE)
shar11 <- mean(dataMale$shar1_1, na.rm = TRUE)

#1_2
intel12 <- mean(dataMale$intel1_2, na.rm=TRUE)
attr12 <- mean(dataMale$attr1_2, na.rm=TRUE)
sinc12 <- mean(dataMale$sinc1_2, na.rm=TRUE)
fun12 <- mean(dataMale$fun1_2, na.rm = TRUE)
amb12 <- mean(dataMale$amb1_2, na.rm = TRUE)
shar12 <- mean(dataMale$shar1_2, na.rm = TRUE)

#1_3
intel13 <- mean(dataMale$intel1_3, na.rm=TRUE)
attr13 <- mean(dataMale$attr1_3, na.rm=TRUE)
sinc13 <- mean(dataMale$sinc1_3, na.rm=TRUE)
fun13 <- mean(dataMale$fun1_3, na.rm = TRUE)
amb13 <- mean(dataMale$amb1_3, na.rm = TRUE)
shar13 <- mean(dataMale$shar1_3, na.rm = TRUE)

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

##Analisis Ketiga ialah dengan melihat korelasi dari semua faktor utama pada dataAllMale
#Fungsi yang digunakan ialah cor() dan divisualisasikan dengan corrplot lewat package "corrplot"
cor1<-cor(dataAllMale[c("dec","intel","attr","sinc","fun","amb","shar")],use="complete") #dilihat korelasinya dengan atribut dec
cor2<-cor(dataAllMale[c("like","intel","attr","sinc","fun","amb","shar")],use="complete") #dilihat korelasinya dengan atribut like
cor3<-cor(dataAllMale[c("match","intel","attr","sinc","fun","amb","shar")],use="complete") #dilihat korelasinya dengan atribut match

#visualisasi matriks korelasi
corrplot.mixed(cor1, upper="number", lower="ellipse")
corrplot.mixed(cor2, upper="number", lower="ellipse")
corrplot.mixed(cor3, upper="number", lower="ellipse")

##Dari tiga analisis di atas, kesimpulannya ialah bahwa rata-rata pria mencari wanita pada awalnya dengan melihat attractiveness-nya.
