import numpy
import pandas
from collections import Counter
import csv

FILE='test.csv'
OUTPUTF='Rata-rata waktu tempuh.csv'

data = pandas.read_csv(FILE)
pindah = 0
for p in data['POLYLINE']:
	pindah = pindah + (((p.count('['))-2)*15)
waktu = pindah / len(data['POLYLINE'])

with open(OUTPUTF, 'w', newline='') as fl:
	tulisf = csv.writer(fl, delimiter=',')
	tulisf.writerow(['Rata-rata waktu tempuh'])
	tulisf.writerow([waktu])