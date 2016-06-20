import json
import numpy
import pandas
import matplotlib.pyplot as plt
import csv
#nama file yang akan dibaca dan file hasil keluaran
FILE='test.csv'
OUTPUTF='Lokasi akhir perjalanan.csv'

#baca file dengan mengconvert nilai dari polyline dan diambil nilai akhirnya
data = pandas.read_csv(FILE, converters={'POLYLINE': lambda x: json.loads(x)[-1:]})
#masukan nilainya kedalam satu, dan mennukar nilainya, lat dan long
poly=[]
for p in data['POLYLINE']:
	if (len(p)>0):
		poly=numpy.append(poly,[p[0][1],p[0][0]])
#setelah di append di buat menjadi item yang berisi koordinat	
poly2d= numpy.reshape(poly,(-1,2))
#koordinat lokasi terakhir dicatat dalam keluaran file
with open(OUTPUTF, 'w', newline='') as fl:
	tulisf = csv.writer(fl, delimiter=',')
	tulisf.writerow(['Lokasi akhir'])
	for y in poly2d:
		tulisf.writerow([y])
#nilai max dan min dari koordinat		
lat_min, lat_max = numpy.percentile(poly2d[:,0], [2, 98])
lon_min, lon_max = numpy.percentile(poly2d[:,1], [2, 98])
#plotting koordinat ke dalam gambar
bins = 513
lat_bins = numpy.linspace(lat_min, lat_max, bins)
lon_bins = numpy.linspace(lon_min, lon_max, bins)
Histo, _, _ = numpy.histogram2d(poly2d[:,0], poly2d[:,1], bins=(lat_bins, lon_bins))
image = numpy.log(Histo[::-1, :] + 1)
#simpan gambar dengan format
plt.figure()
ax = plt.subplot(1,1,1)
plt.imshow(image,cmap = plt.get_cmap('gray'))
plt.axis('off')
plt.savefig("Lokasi Terakhir yang dikunjungi.png",bbox_inches='tight')

