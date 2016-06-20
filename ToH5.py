# Mengubah format data dan melakukan pembersihan data.
# Cara penggunaan: python ToH5.py source.csv dest.h5
import sys
import pandas as pd

# Input
df = pd.read_csv(sys.argv[1], index_col=(0, 1), names=['lat', 'lon'])

# Menghilangkan index duplikat
df = df.reset_index()
df = df.drop_duplicates(subset=['level_0', 'level_1'])
df = df.set_index(['level_0', 'level_1'])

# Output
df.to_hdf(sys.argv[2], 'data')
