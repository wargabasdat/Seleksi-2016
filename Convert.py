import sys
import pandas as pd

dfs = pd.read_csv(sys.argv[1], chunksize=100)

with open(sys.argv[2], 'a') as f:
    for df in dfs:
        sdf = pd.to_numeric(df.POLYLINE
                              .str.split(',', expand=True)
                              .stack()
                              .str.replace('(41\.)|(-8\.)|\[|\]', '')
                              .str.ljust(6, '0'))
        odds = sdf[1::2]
        evens = sdf[::2]
        odds.index = pd.MultiIndex.from_tuples(odds.index.map(lambda x: (x[0], (x[1]-1)//2)))
        evens.index = pd.MultiIndex.from_tuples(evens.index.map(lambda x: (x[0], x[1]//2)))
        fdf = pd.concat([odds, evens], axis=1)
        fdf.to_csv(f, header=False)
