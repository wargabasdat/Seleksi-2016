#import dataset Salaries.csv to mydata
mydata <- read.csv("Salaries.csv",stringsAsFactors=FALSE)
#cek database
str(mydata)
#konversi tipe data
mydata$BasePay <- as.numeric(mydata$BasePay)
mydata$OvertimePay <- as.numeric(mydata$OvertimePay)
mydata$OtherPay <- as.numeric(mydata$OtherPay)
mydata$Benefits <- as.numeric(mydata$Benefits)
#cek data
str(mydata)
#hitung rata-rata pendapatan (dari TotalPayBenefits) berdasarkan tahun
ratarata = aggregate(TotalPayBenefits~Year, data=mydata,mean)
#ganti nama kolom
colnames(ratarata) <- c("tahun","gaji")
#simpan hasil perhitungan rata-rata
write.csv(ratarata, file="RataRata.csv")
##prediksi gaji untuk tahun 2015 dan 2016##
#regresi linear data
model <- lm(gaji~tahun, data=ratarata)
#cek hasil regresi linear
summary(model)
#membuat frame untuk prediksi
prediksi<- data.frame(tahun=2015:2016, gaji=0)
#menggunakan fungsi predict berdasarkan model regresi linear untuk gaji
prediksi$gaji<-predict.lm(model,prediksi)
#simpan hasil prediksi
write.csv(prediksi,file="prediksi.csv")
##visualisasi data##
require(ggplot2)
ggplot(ratarata, aes(x=tahun, y=gaji)) + geom_bar(aes(fill=tahun),stat="identity",position=position_dodge()) + guides(fill=FALSE) + xlab("Tahun") + ylab("Gaji") + ggtitle("Rata-Rata Gaji Penduduk San Francisco")
ggsave("RataRata.png")
#Menggabungkan hasil prediksi ke data frame ratarata
ratarata <- rbind(ratarata,prediksi)
ggplot(ratarata, aes(x=tahun, y=gaji,colour=tahun)) + geom_point(size=2) + guides(color=FALSE) + geom_smooth(method='lm')
ggsave("Regresi.png")
ggplot(ratarata, aes(x=tahun, y=gaji,colour=tahun)) + geom_line() + geom_point(size=3) + guides(color=FALSE) + xlab("Tahun") + ylab("Gaji") + ggtitle("Gaji Penduduk San Francisco dan Prediksi")
ggsave("Prediksi.png")
