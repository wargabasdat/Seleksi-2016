import numpy
import pandas
from collections import Counter
import csv

FILE='train.csv'
OUTPUTF='Rata-rata waktu tempuh.csv'
#baca file
data = pandas.read_csv(FILE)
#cari nilai koordinat selain nilai awal, tiap perpindahan koordinat 15 detik
pindah = 0
simpan = 0
#catat perpindahan yang dilakukan, apabila data gps tidak lengkap (value MISSING_DATA == true), tidak dimasukan 
#ke perhitungan
for p in data['POLYLINE']:
	if (data['MISSING_DATA'][save]==False):
		pindah = pindah + (((p.count('['))-2)*15)
	else:
		simpan = simpan + 1
	save=save+1
#nilainya dibagi dengan panjang data yang tidak hilang data GPSnya
waktu = pindah / (len(data['POLYLINE']) - simpan)
#simpan nilainya ke file output
with open(OUTPUTF, 'w', newline='') as fl:
	tulisf = csv.writer(fl, delimiter=',')
	tulisf.writerow(['Rata-rata waktu tempuh'])
	tulisf.writerow([waktu])
