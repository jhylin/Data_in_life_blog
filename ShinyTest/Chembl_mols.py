import polars as pl

df = pl.read_csv("chembl_mols.csv", sep = ";")

df.head()
