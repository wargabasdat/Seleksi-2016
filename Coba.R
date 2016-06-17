
library(ggplot2)

#Memasukan data ke dalam variabel
Salaries <- read.csv("Salaries.csv", header = TRUE)

ggplot(data=Salaries, aes(TotalPayBenefits, fill=factor(Year))) +
  geom_histogram() +
  facet_wrap( ~ Year, ncol=2)

#Mencari rata2 (nomor 1)
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2011")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2012")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2013")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2014")])

#selisih 1 = 28809.13
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2012")]) - mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2011")])
# selisih 2 = 887.2905
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2013")]) - mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2012")])
#selisih 3 = -1189.601
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2014")]) - mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2013")])

# Pengelompokan
Salaries.Wow <- Salaries
Salaries.Wow$Wew = "Rendah"
Salaries.Wow[which(Salaries.group$TotalPayBenefits > 100000), 'Wew'] = "Menengah"
Salaries.Wow[which(Salaries.group$TotalPayBenefits > 250000), 'Wew'] = "Tinggi"

#Histogram
Salaries.Wow %>%
  ggplot(aes(x=factor(Wew, level=c('Rendah', 'Menengah', 'Tinggi')))) +
  geom_bar() +
  ggtitle("Pengelompokan") +
  ylab("Banyaknya") +
  xlab("W")

table(Salaries.group$Group)

unique(as.character(Salaries$JobTitle))

# No 1
rata <- aggregate(TotalPayBenefits~Year,Salaries,mean)
rata2 <- data.frame(Year=c(2015,2016),TotalPayBenefits = 0)
reg <- lm(rata$TotalPayBenefits~rata$Year,data = rata2)
rata2$TotalPayBenefits <- predict(reg, newdata = rata2)

