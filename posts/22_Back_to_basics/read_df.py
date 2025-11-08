# import pandas (as usual in Python)
import pandas as pd

def reading_df(file):
    # Reading a df (using one of my old cleaned datasets from a while ago)
    df = pd.read_csv(file)
    df = df.rename(columns={"QED Weighted": "QED", "Polar Surface Area": "PSA"})
    
    return df