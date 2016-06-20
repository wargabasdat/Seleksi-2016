# Mengubah bentuk data menjadi dapat digunakan oleh Prediction.py.
# Cara penggunaan: python CreateMLData.py source.h5 dest.h5
import sys
import pandas as pd

# Membaca data sumber yang telah dihasilkan oleh ToH5.py
df = pd.read_hdf(sys.argv[1])

# Menghitung panjang array polyline
counts = df.count(level=0).lat.to_frame('length')
firsts = df.xs(0, level=1)

# Pengecekan index. Seharusnya sudah dihilangkan oleh ToH5.py
if not counts.index.is_unique or not firsts.index.is_unique:
    raise ValueError('Indexes must be unique')

# Penulisan data; dimasukkan dalam dataframe terlebih dahulu
rdf = pd.concat([firsts, counts], axis=1)

# Variabel dihapus untuk membebaskan memori
del df
del counts
del firsts

rdf.to_hdf(sys.argv[2], 'data')
