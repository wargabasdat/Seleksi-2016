# Load data
myData = read.csv("Salaries.csv")

# Hitung mean dari TotalPayBenefits
aggregate(TotalPayBenefits ~ Year, data = myData, mean)

# Pengelompokan Gaji (Rendah, Sedang, Tinggi)
tes <- myData$TotalPayBenefits
X <- cut(tes, c(0,50000,70000,1000000), include.lowest = TRUE, labels=c("Rendah","Sedang","Tinggi"))
