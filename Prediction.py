# Melakukan prediksi panjang perjalanan.
# Cara penggunaan: python Prediction.py trainingdata.h5 testdata.h5 output.csv
import sys
import pandas as pd
import numpy as np
from sklearn.neighbors import RadiusNeighborsRegressor
from sklearn import cross_validation

# Membaca data training dan test
df = pd.read_hdf(sys.argv[1])
tdf = pd.read_hdf(sys.argv[2])

# Mengubah menjadi array numpy yang digunakan scikit-learn
X_train = df.as_matrix(['lat', 'lon'])
y_train = (df.length.as_matrix())*15
X_test = tdf.as_matrix(['lat', 'lon'])
y_test = (tdf.length.as_matrix())*15

id_test = tdf.index.to_series().as_matrix()

# Inisialisasi model
model = RadiusNeighborsRegressor(radius=0.0005, weights='distance')

# Training
model.fit(X_train, y_train)

# Prediksi
y_try = model.predict(X_test)

# Penulisan hasil
resdf = pd.DataFrame({'idx': id_test, 'predict': (y_try), 'actual': (y_test)}).set_index('idx')

resdf.to_csv(sys.argv[3])
