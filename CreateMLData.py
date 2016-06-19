import sys
import pandas as pd

df = pd.read_hdf(sys.argv[1])

counts = df.count(level=0).lat.to_frame('length')
firsts = df.xs(0, level=1)

if not counts.index.is_unique or not firsts.index.is_unique:
    raise ValueError('Indexes must be unique')

rdf = pd.concat([firsts, counts], axis=1)
del df
del counts
del firsts

rdf.to_hdf(sys.argv[2], 'data')
