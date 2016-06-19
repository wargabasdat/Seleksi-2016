import json
import numpy
import pandas
import folium

FILE='test.csv'
OUTPUTF='mapTaxi.html'

print("Reading file..")
data = pandas.read_csv(FILE, converters={'POLYLINE': lambda x: json.loads(x)[-1:]})
poly=[]
for p in data['POLYLINE']:
	poly=numpy.append(poly,[p[0][1],p[0][0]])
	
poly2d= numpy.reshape(poly,(-1,2))

print("Make a Map..")
mapTaxi = folium.Map(location=[poly2d[0][0],poly2d[0][1]], zoom_start=20)
for x,y in poly2d:
	folium.Marker([x,y],icon=folium.Icon(icon='cloud')).add_to(mapTaxi)
mapTaxi.lat_lng_popover()
mapTaxi.save(OUTPUTF)