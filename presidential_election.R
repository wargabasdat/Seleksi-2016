# Pemilihan Presiden
# Kelompok 4
# Hishshah Ghassani (13514056)
# Devita Yufliha Mahron (18214001)

# Menggunakan RStudio


# Set Working Directory
setwd("~/Desktop/basdat/2016_presidential_election")

# Library yang digunakan
library(readr)

# Import CSV
results <- read_csv("primary_results.csv")              # Menyimpan data pada file primary_results.csv ke results
facts <- read_csv("county_facts.csv")                   # Menyimpan data pada file county_facts.csv ke facts
data <- merge(results, facts, by="fips")                # Menggabungkan results dan facts berdasarkan fips
dictionary <- read_csv("county_facts_dictionary.csv")   # Menyimpan data pada file county_facts_dictionary.csv ke dictionary

# Mengambil data yang candidate-nya adalah Donald Trump dan menyimpannya pada datasubset
dataf <- data.frame(data)
datasubset <- subset(dataf, candidate == "Donald Trump")

# Membuat dataframe bernama rataan yang berisi rata-rata tiap demografik (PST045214, PST040210, dll) untuk kandidat Donald Trump
rataan <- data.frame("column_name" = dictionary$column_name, "description" = dictionary$description)
rataan$mean <- c(colMeans(datasubset[datasubset$candidate== "Donald Trump", dictionary$column_name]))

# Mengurutkan rataan berdasarkan rata-rata secara ascending
rataan <- rataan[order(rataan$mean),]

# Menghitung persentase 
highschoolGraduate <- rataan$mean[rataan$column_name=="EDU635213"]
bachelorsDegree <- rataan$mean[rataan$column_name=="EDU685213"]
totalvotes <- sum(datasubset$votes)
percentage <- (totalvotes-(highschoolgraduate+bachelorsdegree)) / totalvotes

# Jika diasumsikan setiap setiap high school graduate mengenyam bangku kuliah,
# maka persentasi masyarakat pendukung Donald Trump yang tidak mengenyam bangku kuliah adalah percentage, yaitu 0.9999855.
# Sehingga terbukti bahwa mayoritas orang Amerika Serikat yang mendukung Donald Trump berasal dari kalangan masyarakat yang tidak mengenyam bangku kuliah.

# Faktor dominan lain pendukung Trump adalah masyarakat dari kalangan produsen pengiriman.
# Dapat dilihat dari: rata-rata untuk MAN450207 (Manufacturers shipments) paling tinggi dibandingkan demografik lainnya.