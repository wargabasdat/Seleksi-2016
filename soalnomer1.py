import pandas
import json
import numpy
import csv
#nama file yang akan dibaca dan file hasil keluaran
FILE='test.csv' 
OUTPUTF='Lokasi yang paling sering dikunjungi.csv'

#baca file dengan mengconvert nilai dari polyline dan diambil nilai akhirnya
data = pandas.read_csv(FILE, converters={'POLYLINE': lambda x: json.loads(x)[-1:]})
#masukan nilainya kedalam satu, dan mennukar nilainya, lat dan long
poly=[]
for p in data['POLYLINE']:
	poly=numpy.append(poly,[p[0][1],p[0][0]])
#setelah di append di buat menjadi item yang berisi koordinat	
poly2d= numpy.reshape(poly,(-1,2))
#membuat file keluaran dan mencari nilai koordinat yang paling banyak muncul dari data poly2d
axis = 0
u, indices = numpy.unique(poly2d, return_inverse=True)
with open(OUTPUTF, 'w', newline='') as fl:
	tulisf = csv.writer(fl, delimiter=',')
	lokasi = [u[numpy.argmax(numpy.apply_along_axis(numpy.bincount, axis, indices.reshape(poly2d.shape),None, numpy.max(indices) + 1), axis=axis)]]
	tulisf.writerow(['Lokasi yang paling sering dikunjungi'])
	tulisf.writerow(lokasi)
