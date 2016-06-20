# Mengubah bentuk data menjadi lebih mudah digunakan.
# Cara penggunaan: python Convert.py source.csv dest.csv
import sys
import pandas as pd

print("reading data...")
# Buka file dalam chunk sehingga hemat memori
dfs = pd.read_csv(sys.argv[1], index_col=0, chunksize=10000)

print("writing up...")

with open(sys.argv[2], 'w') as f:
    for df in dfs:
        # Mengubah string polyline menjadi array
        pol = df.POLYLINE
        cpl = pol[~(pol == '[]')]
        sdf = pd.to_numeric(cpl.str.split(',', expand=True)
                               .stack()
                               .str.replace('\[|\]', ''))
        # Menempatkan longitude dan latitude pada kolom berbeda
        odds = sdf[1::2]
        evens = sdf[::2]
        odds.index = pd.MultiIndex.from_tuples(odds.index.map(lambda x: (x[0], (x[1]-1)//2)))
        evens.index = pd.MultiIndex.from_tuples(evens.index.map(lambda x: (x[0], x[1]//2)))
        fdf = pd.concat([odds, evens], axis=1)

        # Jangan menulis header karena akan menulis ke tengah file
        fdf.to_csv(f, header=False)
