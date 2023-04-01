# Using Polars to manipulate the chembl dataset first
# Finding Sparklyr & Spark connection bit slow with single node connection

import polars as pl

df = pl.read_csv("chembl_mols.csv", sep = ";")

df.head()

df_new = df.with_columns(
    [
        (pl.col("Molecular Weight")).cast(pl.Float64, strict = False),
        (pl.col("Targets")).cast(pl.Int64, strict = False),
        (pl.col("Bioactivities")).cast(pl.Int64, strict = False),
        (pl.col("AlogP")).cast(pl.Float64, strict = False),
        (pl.col("Polar Surface Area")).cast(pl.Float64, strict = False),
        (pl.col("HBA")).cast(pl.Int64, strict = False),
        (pl.col("HBD")).cast(pl.Int64, strict = False),
        (pl.col("#RO5 Violations")).cast(pl.Int64, strict = False),
        (pl.col("#Rotatable Bonds")).cast(pl.Int64, strict = False),
        (pl.col("QED Weighted")).cast(pl.Float64, strict = False),
        (pl.col("CX Acidic pKa")).cast(pl.Float64, strict = False),
        (pl.col("CX Basic pKa")).cast(pl.Float64, strict = False),
        (pl.col("CX LogP")).cast(pl.Float64, strict = False),
        (pl.col("CX LogD")).cast(pl.Float64, strict = False),
        (pl.col("Aromatic Rings")).cast(pl.Int64, strict = False),
        (pl.col("Heavy Atoms")).cast(pl.Int64, strict = False),
        (pl.col("HBA (Lipinski)")).cast(pl.Int64, strict = False),
        (pl.col("HBD (Lipinski)")).cast(pl.Int64, strict = False),
        (pl.col("#RO5 Violations (Lipinski)")).cast(pl.Int64, strict = False),
        (pl.col("Molecular Weight (Monoisotopic)")).cast(pl.Float64, strict = False)
    ]
)
df_new.head()

df_new.null_count()

df_dn = df_new.drop_nulls()
df_dn 

df_dn.filter(pl.col("Type") == "Small molecule")

# Quickly check column names and first 10 variables in each column
#print(df_dn.glimpse())

df_full = df_dn.filter(
    (pl.col("Type") == "Small molecule"))
).select(["ChEMBL ID", 
          "Type", 
          "Max Phase",
          "#RO5 Violations", 
          "QED Weighted", 
          "Molecular Weight",
          "Polar Surface Area"]
        )
df_full

# Drop columns
df_full = df_full.drop(["ChEMBL ID",
              "Type",
              "Name", 
              "Synonyms", 
              "CX Acidic pKa",
              "CX Basic pKa",
              "CX LogP",
              "CX LogD",
              "Structure Type",
              "Passes Ro3",
              "#RO5 Violations (Lipinski)",
              "Inorganic Flag",
              "Heavy Atoms", 
              "HBA (Lipinski)",
              "HBD (Lipinski)",
              "Molecular Weight (Monoisotopic)",
              "Molecular Species", 
              "Molecular Formula", 
              "Smiles", 
              "Inchi Key"]
              )

df_full

print(df_full.glimpse())

# Extract the cleaned/condensed dataframe into working directory
df_full.write_csv("chembl_m.csv", sep = ",")
