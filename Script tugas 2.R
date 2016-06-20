#library yang digunakan
library(ggplot2)
library(dplyr)
library(readr)

#Memasukan data ke dalam variabel
Salaries <- read.csv("Salaries.csv", header = TRUE)

#####
#Mencari rata2 (point a)
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2011")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2012")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2013")])
mean(Salaries$TotalPayBenefits[which(Salaries$Year == "2014")])

#Mencari prediksi
rata <- aggregate(TotalPayBenefits ~ Year, Salaries, mean)
reg <- lm(rata$TotalPayBenefits~rata$Year, data = rata)
rata2 <- rata
rata <- data.frame(Year=c(2015,2016), TotalPayBenefits = 0)
rata$TotalPayBenefits <- predict(reg, rata)

rata2 <- rbind(rata2, rata) #menggabungkan

#histogram nomor 1
ggplot(data=rata2,aes(x = Year, y = TotalPayBenefits)) + 
  geom_bar(colour = "blue",stat = "identity") +
  ggtitle("Rata-rata Pendapatan Penduduk San Francisco") +
  ylab("Total Pay Benefits") + 
  xlab("Year")

#########
#Nomor 2
#Pengelompokan pendapatan dari yang rendah hingga tinggi
Salaries.Job <- Salaries
Salaries.Job$Group = "Rendah"
Salaries.Job[which(Salaries.Job$TotalPayBenefits > 65000), 'Group'] = "Menengah"
Salaries.Job[which(Salaries.Job$TotalPayBenefits > 100000), 'Group'] = "Tinggi"

#Histogram
Salaries.Job %>%
  ggplot(aes(x=factor(Group, level=c('Rendah', 'Menengah', 'Tinggi')))) +
  geom_bar() + aes(fill=factor(Year)) +
  ggtitle("Pengelompokan Berdasarkan Besar Pendapatan") +
  ylab("Jumlah") +
  xlab("Tingkat")

table(Salaries.Job$Group)

######
#No 3 (poin c)
#Mengubah semua tulisan menjadi huruf besar
Salaries.Job$JobTitle <- toupper(Salaries.Job$JobTitle) 

#Mengecek atribut yang unik
#unique(as.character(Salaries.Job$JobTitle))


Salaries.Job$Job = "Other"
Salaries.Job[which(grepl('FIRE',Salaries.Job$JobTitle)), 'Job'] = "Fire"
Salaries.Job[which(grepl('POLICE',Salaries.Job$JobTitle)), 'Job'] = "Police"
Salaries.Job[which(grepl('SHERIF',Salaries.Job$JobTitle)), 'Job'] = "Police"
Salaries.Job[which(grepl('PROBATION',Salaries.Job$JobTitle)), 'Job'] = "Police"
Salaries.Job[which(grepl('SERGEANT',Salaries.Job$JobTitle)), 'Job'] = "Police"
Salaries.Job[which(grepl('INSPECTOR',Salaries.Job$JobTitle)), 'Job'] = "Police"
Salaries.Job[which(grepl('LIEUTENANT',Salaries.Job$JobTitle)), 'Job'] = "Police"
Salaries.Job[which(grepl('MTA',Salaries.Job$JobTitle)), 'Job'] = "Transit"
Salaries.Job[which(grepl('TRANSIT',Salaries.Job$JobTitle)), 'Job'] = "Transit"
Salaries.Job[which(grepl('ANESTH',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('MEDICAL',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('NURS',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('PHYSICIAN',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('HEALTH',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('ORTHOPEDIC',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('HEALTH',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('PHARM',Salaries.Job$JobTitle)), 'Job'] = "Medical"
Salaries.Job[which(grepl('DENTIST',Salaries.Job$JobTitle)), 'Job'] = "Medical"

Salaries.Job[which(grepl('AIRPORT',Salaries.Job$JobTitle)), 'Job'] = "Airport"
Salaries.Job[which(grepl('ANIMAL',Salaries.Job$JobTitle)), 'Job'] = "Animal"
Salaries.Job[which(grepl('ARCHITECT',Salaries.Job$JobTitle)), 'Job'] = "Architectural"
Salaries.Job[which(grepl('COURT',Salaries.Job$JobTitle)), 'Job'] = "Court"
Salaries.Job[which(grepl('LEGAL',Salaries.Job$JobTitle)), 'Job'] = "Court"
Salaries.Job[which(grepl('DEFENDER',Salaries.Job$JobTitle)), 'Job'] = "Court"
Salaries.Job[which(grepl('CRIMINAL',Salaries.Job$JobTitle)), 'Job'] = "Court"
Salaries.Job[which(grepl('VICTIM',Salaries.Job$JobTitle)), 'Job'] = "Court"

Salaries.Job[which(grepl('MAYOR',Salaries.Job$JobTitle)), 'Job'] = "Mayor"
Salaries.Job[which(grepl('LIBRAR',Salaries.Job$JobTitle)), 'Job'] = "Library"
Salaries.Job[which(grepl('PARKING',Salaries.Job$JobTitle)), 'Job'] = "Parking"
Salaries.Job[which(grepl('PUBLIC WORKS',Salaries.Job$JobTitle)), 'Job'] = "Public Works"
Salaries.Job[which(grepl('PUBLIC SERVICE',Salaries.Job$JobTitle)), 'Job'] = "Public Works"
Salaries.Job[which(grepl('INSPECTOR',Salaries.Job$JobTitle)), 'Job'] = "Public Works"

Salaries.Job[which(grepl('ATTORNEY',Salaries.Job$JobTitle)), 'Job'] = "Attorney"
Salaries.Job[which(grepl('MECHANIC',Salaries.Job$JobTitle)), 'Job'] = "Automotive"
Salaries.Job[which(grepl('AUTOMOTIVE',Salaries.Job$JobTitle)), 'Job'] = "Automotive"
Salaries.Job[which(grepl('CUSTODIAN',Salaries.Job$JobTitle)), 'Job'] = "Custodian"
Salaries.Job[which(grepl('ENGINEER',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('ENGR',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('ACCOUNT',Salaries.Job$JobTitle)), 'Job'] = "Accounting"
Salaries.Job[which(grepl('AUDITOR',Salaries.Job$JobTitle)), 'Job'] = "Accounting"
Salaries.Job[which(grepl('GARDENER',Salaries.Job$JobTitle)), 'Job'] = "Gardening"
Salaries.Job[which(grepl('GENERAL LABORER',Salaries.Job$JobTitle)), 'Job'] = "General"
Salaries.Job[which(grepl('FOOD SERV',Salaries.Job$JobTitle)), 'Job'] = "Food Service"
Salaries.Job[which(grepl('CLERK',Salaries.Job$JobTitle)), 'Job'] = "Clerk"
Salaries.Job[which(grepl('PORTER',Salaries.Job$JobTitle)), 'Job'] = "Porter"
#others
Salaries.Job[which(grepl('DEPUTY',Salaries.Job$JobTitle)), 'Job'] = "Politics"
Salaries.Job[which(grepl('MANAGER',Salaries.Job$JobTitle)), 'Job'] = "Manager"
Salaries.Job[which(grepl('TECHNICIAN',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('CONTROLLER',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('ELECTRIC',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('PLUMBER',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('TECH',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('PROGRAM',Salaries.Job$JobTitle)), 'Job'] = "Engineering"



Salaries.Job[which(grepl('DEPARTMENT',Salaries.Job$JobTitle)), 'Job'] = "Politics"
Salaries.Job[which(grepl('LEGISLATIVE',Salaries.Job$JobTitle)), 'Job'] = "Politics"
Salaries.Job[which(grepl('SECRETARY',Salaries.Job$JobTitle)), 'Job'] = "Politics"
Salaries.Job[which(grepl('DEPT',Salaries.Job$JobTitle)), 'Job'] = "Politics"
Salaries.Job[which(grepl('EMPLOYEE',Salaries.Job$JobTitle)), 'Job'] = "Public Works"
Salaries.Job[which(grepl('PROTECTIVE',Salaries.Job$JobTitle)), 'Job'] = "Public Works"
Salaries.Job[which(grepl('SOCIAL',Salaries.Job$JobTitle)), 'Job'] = "Public Works"
Salaries.Job[which(grepl('MAINTENANCE',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('ANALYST',Salaries.Job$JobTitle)), 'Job'] = "Analyst"
Salaries.Job[which(grepl('ADMINISTRATOR',Salaries.Job$JobTitle)), 'Job'] = "Administrator"
Salaries.Job[which(grepl('PLANNER',Salaries.Job$JobTitle)), 'Job'] = "Engineering"
Salaries.Job[which(grepl('DRIVER',Salaries.Job$JobTitle)), 'Job'] = "Driver"

#Histogram point c
Salaries.Job %>%
  ggplot(aes(x=Job)) +
  geom_bar() + aes(fill=factor(Group)) +
  ggtitle("Pengelompokan Berdasarkan Bidang Pekerjaan") +
  ylab("Jumlah") +
  xlab("Bidang Pekerjaan") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

table(Salaries.Job$Job)


#Menuliskan table ke file csv
write.csv(Salaries.Job, file = "Salaries_new.csv")
write.csv(rata2, file = "ratarata.csv")
View(Salaries.Job)
View(rata2)
