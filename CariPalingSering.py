import sys
import pandas as pd

df = pd.read_hdf(sys.argv[1])

cts = df.groupby(['lat', 'lon']).size()

scts = cts.sort_values()

print(scts.tail(1))
