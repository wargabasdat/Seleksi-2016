import pandas
import json
import numpy
import csv
from math import *

#deklarasi fungsi: menghitung jarak antara 2 koordinat
def great_circle_distance(coordinates1, coordinates2):
  latitude1, longitude1 = coordinates1
  latitude2, longitude2 = coordinates2
  d = pi / 180  # factor to convert degrees to radians
  return acos(sin(longitude1*d) * sin(longitude2*d) +
              cos(longitude1*d) * cos(longitude2*d) *
              cos((latitude1 - latitude2) * d)) / d

#deklarasi fungsi: mengembalikan boolean; apakah hasil great_circle_distance berada pada range
def in_range(coordinates1, coordinates2, range):
  return great_circle_distance(coordinates1, coordinates2) < range

#nama file yang akan dibaca dan file hasil keluaran
FILE='train.csv' 
OUTPUTF='Lokasi yang paling sering dikunjungi.csv'

#baca file dengan mengconvert nilai dari polyline dan diambil nilai akhirnya
data = pandas.read_csv(FILE, converters={'POLYLINE': lambda x: json.loads(x)[-1:]})
cek=pandas.read_csv('metaData_taxistandsID_name_GPSlocation.csv')
#masukan nilainya kedalam satu, dan mennukar nilainya, lat dan long
poly=[]
for p in data['POLYLINE']:
	if (len(p)>0):
		poly=numpy.append(poly,[p[0][1],p[0][0]])
#setelah di-append dibuat menjadi item yang berisi koordinat	
poly2d= numpy.reshape(poly,(-1,2))
#proses long dan lat dari cek
lat=[]
for k in cek['Latitude']:
	lat=numpy.append(lat,float(k))

lon=[]
for w in cek['Longitude']:
	lon=numpy.append(lon,float(w))
lat1d= numpy.reshape(lat,(-1,1))
lon1d= numpy.reshape(lon,(-1,1))

meta=numpy.hstack((lat1d,lon1d))
#membuat file keluaran dan mencari nilai koordinat yang paling banyak muncul dari data poly2d
axis = 0
u, indices = numpy.unique(poly2d, return_inverse=True)
u, indices = numpy.unique(poly2d, return_inverse=True)
lokas=u[numpy.argmax(numpy.apply_along_axis(numpy.bincount, axis, indices.reshape(poly2d.shape),None, numpy.max(indices) + 1), axis=axis)]
on=False
ind=0
while on==False:
	if in_range(lokas, meta[ind], 0.009 )==True:
		on=True
	else:
		ind=ind+1
with open(OUTPUTF, 'w', newline='') as fl:
	tulisf = csv.writer(fl, delimiter=',')
	lokasi = [u[numpy.argmax(numpy.apply_along_axis(numpy.bincount, axis, indices.reshape(poly2d.shape),None, numpy.max(indices) + 1), axis=axis)]]
	tulisf.writerow(['Lokasi yang paling sering dikunjungi'])
	tulisf.writerow(lokasi)
	tulisf.writerow([lokas])
