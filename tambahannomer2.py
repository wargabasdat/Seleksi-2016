import json
import numpy
import pandas
import folium

#File keluaran dan file yang dibaca
FILE='test.csv'
OUTPUTF='mapTaxi.html'

#membuat yang mungcul beberapa kali menjadi sati kali
def unique(a):
	order = numpy.lexsort(a.T)
	a = a[order]
	diff = numpy.diff(a,axis=0)
	ui = numpy.ones(len(a),'bool')
	ui[1:] = (diff != 0).any(axis = 1)
	return a[ui]

#baca file
print("Reading file..")
data = pandas.read_csv(FILE, converters={'POLYLINE': lambda x: json.loads(x)[-1:]})
poly=[]
for p in data['POLYLINE']:
	poly=numpy.append(poly,[p[0][1],p[0][0]])
	
poly2d= numpy.reshape(poly,(-1,2))

unik = unique(poly2d)
#membuat map dengan folium
print("Make a Map..")
mapTaxi = folium.Map(location=[poly2d[0][0],poly2d[0][1]], zoom_start=20)
for x,y in unik:
	folium.Marker([x,y],icon=folium.Icon(icon='cloud')).add_to(mapTaxi)
mapTaxi.lat_lng_popover()
mapTaxi.save(OUTPUTF)
