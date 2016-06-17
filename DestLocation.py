
import time
import json
import numpy as np
import pandas as pd
import CoordinateToPlace as gp

#from utils import haversineKaggle, heading, CITY_CENTER

def processRow(row):
    x = row['POLYLINE']
    if len(x)>1:
        x = np.array(x, ndmin=2)
        #data = process_trip(x[0, :], row['TIMESTAMP'])
        #data += [x[-1,1], x[-1,0], len(x)]
        destinationTuple = (x[-1,1], x[-1,0])
        place = gp.getPlace(destinationTuple)
        data = [x[-1,1], x[-1,0], place, len(x)]
    else:
        data = [-1]*3
        data += [len(x)]
    return pd.Series(np.array(data, dtype=float))

t0 = time.time()
"""
FEATURES = ['wday','hour','xs','ys','d_st','heading']
"""
gp.initializePlaceList()

print('reading training data ...')
df = pd.read_csv('train.csv', converters={'POLYLINE': lambda x: json.loads(x)})#, nrows=100)

print('preparing train data ...')
ds = df.apply(processRow, axis=1)
"""
ds.columns = FEATURES + ['Destination Latitude','Destination Longitude','Number Of Points']
keep_col = ['Destination Latitude','Destination Longitude', 'Number Of Points']
ds = ds[keep_col]
"""
ds.columns = ['Destination Latitude','Destination Longitude','Place ID', 'Number of Places Passed By']
"""
df.drop(['POLYLINE','TIMESTAMP','TRIP_ID','DAY_TYPE','ORIGIN_CALL','ORIGIN_STAND'], 
        axis=1, inplace=True)
"""
df = df.join(ds)

# clean up tracks`
df = df[(df['Destination Latitude'] != -1) & (df['MISSING_DATA']==False)]
df.drop(['MISSING_DATA'], axis=1, inplace=True)
df.to_csv('destLocation_train.csv', index=False)

print('reading test data ...')
df = pd.read_csv('test.csv', converters={'POLYLINE': lambda x: json.loads(x)})

print('preparing test data ...')
ds = df.apply(processRow, axis=1)
"""
ds.columns = FEATURES + ['Destination Latitude','Destination Longitude','Number Of Points']
keep_col = ['Destination Latitude','Destination Longitude', 'Number Of Points']
ds = ds[keep_col]
"""
ds.columns = ['Destination Latitude','Destination Longitude','Place ID', 'Number of Places Passed By']
"""
df.drop(['POLYLINE','TIMESTAMP','DAY_TYPE','ORIGIN_CALL','ORIGIN_STAND',
         'MISSING_DATA'], axis=1, inplace=True)
"""
df = df.join(ds)
df.to_csv('destLocation_test.csv', index=False)

print('Done in %.1f sec.' % (time.time()-t0))


"""

def process_row_test(row):
    x = row['POLYLINE']
    x = np.array(x, ndmin=2)
    data = process_trip(x[0, :], row['TIMESTAMP'])
    return pd.Series(np.array(data, dtype=float))

def process_trip(x, start_time):
    tt = time.localtime(start_time)
    data = [tt.tm_wday, tt.tm_hour]
    # distance from the center till cutting point
    d_st = haversineKaggle(x,  CITY_CENTER)
    head = heading(x,  CITY_CENTER[0])
    data += [x[0], x[1], d_st, head]
    return data

"""

"""
print('preparing test data ...')
ds = df.apply(process_row_test, axis=1)
ds.columns = FEATURES
df.drop(['POLYLINE','TIMESTAMP','DAY_TYPE','ORIGIN_CALL','ORIGIN_STAND',
         'MISSING_DATA'], axis=1, inplace=True)
df = df.join(ds)
df.to_csv('test_Lokasi_Terakhir_1.csv', index=False)

df['TAXI_ID'] -= np.min(df['TAXI_ID'])   # makes csv smaller -> ids in [0, 980]
"""



