import json
import zipfile
import numpy as np
import pandas as pd
#import matplotlib.pyplot as plt
import itertools
import operator

def most_common(L):
  # get an iterable of (item, iterable) pairs
  SL = sorted((x, i) for i, x in enumerate(L))
  # print 'SL:', SL
  groups = itertools.groupby(SL, key=operator.itemgetter(0))
  # auxiliary function to get "quality" for an item
  def _auxfun(g):
    item, iterable = g
    count = 0
    min_index = len(L)
    for _, where in iterable:
      count += 1
      min_index = min(min_index, where)
    # print 'item %r, count %r, minind %r' % (item, count, min_index)
    return count, -min_index
  # pick the highest-count/earliest item
  return max(groups, key=_auxfun)[0]

print("RENDERING")
df = pd.read_csv('test.csv', converters={'POLYLINE': lambda x: json.loads(x)[1:]}) #jd yg diambil cuma yg akhir weh
print(df['POLYLINE'])
#for di dlm for jd nanti semuanya kesiimpen dlm satu array, add terus pake axis=0?
#latlong = np.array([[p[0][1], p[0][0]] for p in df['POLYLINE'] if len(p)>0])
tes=[]
print("COBA")
i = 0
for p in df['POLYLINE']:
	for k in p:
		print(k)
		tes=np.append(tes,[k[1],k[0]])
		i=i+15
j = len(df['POLYLINE'])
waktu = i/j


print(waktu)
print("TES")
#terus=np.array([[p[1][1], p[1][0]] for p in df['POLYLINE'] if len(p)>0])
#print(terus)
#print(df['POLYLINE'])
#latlong1 = np.append(latlong,([[p[1][1], p[1][0]] for p in df['POLYLINE'] if len(p)>0]))
ll= np.reshape(tes,(-1,2))
#print(ll)
# cut off long distance trips
print("paling banyak")
ban=most_common(ll)
print(ban)

lat_low, lat_hgh = np.percentile(ll[:,0], [2, 98]) #di seluruh kolom bagian long
#print(lat_low)
#print("TEES")
#rint(lat_hgh)
lon_low, lon_hgh = np.percentile(ll[:,1], [2, 98]) #diseluruh kolom bagian lat
#print()
#print(lon_low)
#rint("TEES")
#rint(lon_hgh)
# create image
bins = 513
lat_bins = np.linspace(lat_low, lat_hgh, bins)
print()
#print(lat_bins)
print()
lon_bins = np.linspace(lon_low, lon_hgh, bins)
#print(lon_bins)
H2, _, _ = np.histogram2d(ll[:,0], ll[:,1], bins=(lat_bins, lon_bins))
print()
#print(H2)
img = np.log(H2[::-1, :] + 1)
waktu = i/j
print(j)
print(waktu)

#plt.figure()
#ax = plt.subplot(1,1,1)
#plt.imshow(img,cmap = plt.get_cmap('gray'))
#plt.axis('off')

#plt.savefig("taxi_trip_end_point.png")
