# Source code untuk prediksi
# Masih bisa salah
# Belum ada visualisasi
mydata = read.csv("Salaries.csv")
rata = aggregate(TotalPayBenefits~Year, data = mydata, mean)

# Baigan regresi linear
reg <- lm(rata$TotalPayBenefits~rata$Year, data=rata)

# Copy frame rata sebelumnya
rata2 = rata

# Membuat frame baru untuk tahun 2015 dan 2016
rata <- data.frame(Year=2015:2016, TotalPayBenefits=0)

# Mengisi nilai TotalPayBenefits dengan nilai prediksi berdasarkan regresi linear
rata$TotalPayBenefits <- predict.lm(reg,rata)

# Menggabungkan dua data frame yang berbeda
rataTotal <- rbind(rata2,rata)

print(rataTotal)