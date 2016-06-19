import numpy
import pandas
from collections import Counter
import csv

FILE='test.csv'
OUTPUTF='Rata-rata waktu tempuh.csv'
#baca file
data = pandas.read_csv(FILE)
#cari nilai koordinat selain nilai awal, tiap perpindahan koordinat 15 detik
pindah = 0
simpan = 0
for p in data['POLYLINE']:
	if (p.count('[')!=0):
		pindah = pindah + (((p.count('['))-2)*15)
	else:
		simpan = simpan + 1
#nilainya dibagi dengan panjang data yang tidak hilang data GPSnya
waktu = pindah / (len(data['POLYLINE']) - simpan)
#simpan nilainya ke file output
with open(OUTPUTF, 'w', newline='') as fl:
	tulisf = csv.writer(fl, delimiter=',')
	tulisf.writerow(['Rata-rata waktu tempuh'])
	tulisf.writerow([waktu])
