library(ggplot2)

# Load data
mydata = read.csv("Salaries.csv")

# Proses pengambilan data gaji per tahun
tes1 <- subset(mydata, Year==2011)
tes2 <- subset(mydata, Year==2012)
tes3 <- subset(mydata, Year==2013)
tes4 <- subset(mydata, Year==2014)
tes1 <- tes1$TotalPayBenefits
tes2 <- tes2$TotalPayBenefits
tes3 <- tes3$TotalPayBenefits
tes4 <- tes4$TotalPayBenefits

# Pengelompokan Gaji (Rendah, Sedang, Tinggi) dilakukan per tahun
# Pengelompokan Rendah (0,mean-stdev)
# Pengelompokan Sedang (mean-stdev,mean+stdev)
# Pengelompokan Tinggi (>mean+stdev)
gaji11 <- cut(tes1, c(min(tes1)-100,mean(tes1)-sd(tes1),mean(tes1)+sd(tes1),max(tes1)+100), include.lowest=TRUE, include.highest=TRUE, labels = c("Rendah","Sedang","Tinggi"))
gaji12 <- cut(tes2, c(min(tes2)-100,mean(tes2)-sd(tes2),mean(tes2)+sd(tes2),max(tes2)+100), include.lowest=TRUE, include.highest=TRUE, labels = c("Rendah","Sedang","Tinggi"))
gaji13 <- cut(tes3, c(min(tes3)-100,mean(tes3)-sd(tes3),mean(tes3)+sd(tes3),max(tes3)+100), include.lowest=TRUE, include.highest=TRUE, labels = c("Rendah","Sedang","Tinggi"))
gaji14 <- cut(tes4, c(min(tes4)-100,mean(tes4)-sd(tes4),mean(tes4)+sd(tes4),max(tes4)+100), include.lowest=TRUE, include.highest=TRUE, labels = c("Rendah","Sedang","Tinggi"))

# Menggabungkan kembali data-data gaji
Gaji <- append(gaji11,gaji12)
Gaji <- append(Gaji,gaji13)
Gaji <- append(Gaji,gaji14)

# Data Pengelompokan Gaji berubah menjadi 1, 2, dan 3
# Data tersebut dikembalikan ke tulisan Rendah, Sedang, atau Tinggi
Gaji <- as.character(Gaji)
Gaji[Gaji == "3"] <- "Tinggi"
Gaji[Gaji == "2"] <- "Sedang"
Gaji[Gaji == "1"] <- "Rendah"
Gaji <- as.factor(Gaji)

# Menuliskan data .csv
write.csv(Gaji, file="~/Desktop/PengelompokanGaji.csv")

# Visualisasi data
ggsave("~/Desktop/Pengelompokan_Gaji.png", plot = qplot(Gaji, data = mydata, geom = "bar", fill = Gaji, main = "Pengelompokan Gaji San Fransisco"))
