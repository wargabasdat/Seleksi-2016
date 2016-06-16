library(ggplot2)

# Load data
myData = read.csv("Salaries.csv")

# Pengelompokan Gaji (Rendah, Sedang, Tinggi)
# Pengelompokan Rendah (0,mean-stdev)
# Pengelompokan Sedang (mean-stdev,mean+stdev)
# Pengelompokan Tinggi (>mean+stdev)
tes <- myData$TotalPayBenefits
Pengelompokan_gaji <- cut(tes, c(0,mean(tes)-sd(tes),mean(tes)+sd(tes),max(tes)), include.lowest=TRUE, include.highest=TRUE, labels = c("Rendah","Sedang","Tinggi"))

# Visualisasi data
qplot(Pengelompokan_gaji, data = mydata, geom = "bar", colour = Pengelompokan_gaji)
