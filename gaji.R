
library(ggplot2)
library(dplyr)
library(readr)

#Memasukan data ke dalam variabel
Salaries <- read.csv("Salaries.csv", header = TRUE)

#Mencari rata2 (nomor 1)
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2011")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2012")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2013")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2014")])

#No 1
rata <- aggregate(TotalPayBenefits ~ Year, Salaries, mean)
reg <- lm(rata$TotalPayBenefits~rata$Year, data = rata)
rata2 <- rata
rata <- data.frame(Year=c(2015,2016), TotalPayBenefits = 0)
rata$TotalPayBenefits <- predict(reg, rata)
data.combined <- rbind(rata, rata2)

rata2 <- rbind(rata2, rata)

#histogram nomor 1
ggplot(data=rata2,aes(x = Year, y = TotalPayBenefits)) + 
  geom_bar(colour = "blue",stat = "identity") +
  ggtitle("Rata-rata Pendapatan Penduduk San Francisco") +
  ylab("Total Pay Benefits") + 
  xlab("Year")

#########
#Nomor 2
#Pengelompokan pendapatan dari yang rendah hingga tinggi
Salaries.Wow <- Salaries
Salaries.Wow$Wew = "Rendah"
Salaries.Wow[which(Salaries.Wow$TotalPayBenefits > 75000), 'Wew'] = "Menengah"
Salaries.Wow[which(Salaries.Wow$TotalPayBenefits > 160000), 'Wew'] = "Tinggi"

#Histogram
Salaries.Wow %>%
  ggplot(aes(x=factor(Wew, level=c('Rendah', 'Menengah', 'Tinggi')))) +
  geom_bar() +
  ggtitle("Pengelompokan Berdasarkan Besar Pendapatan") +
  ylab("Jumlah") +
  xlab("Tingkat")

table(Salaries.Wow$Wew)

#unique(as.character(Salaries$JobTitle))

#unique(as.character(Salaries$JobTitle))

#No 3
Salaries.Job <- Salaries
Salaries.Job[which(grepl('FIRE',Salaries.Job$JobTitle)), 'Job'] = "Fire"
Salaries.Job[which(grepl('POLICE',Salaries.Job$JobTitle)), 'Job'] = "Police"


#Histogram
Salaries.Job %>%
  ggplot(aes(x=Job)) +
  geom_bar(aes(fill=factor(JobTitle))) + 
  ggtitle("Pengelompokan Berdasarkan Besar Pendapatan") +
  ylab("Jumlah") +
  xlab("Tingkat")