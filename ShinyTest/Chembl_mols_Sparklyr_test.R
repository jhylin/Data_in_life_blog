# import sparklyr package
library(sparklyr)

# Check for available versions of Spark
#spark_available_versions()

# install Spark locally
#spark_install(version = 3.3)

# Connect to Spark
# spark_connect is able to start & connect to the single node Spark cluster on our machines
# note: sc variable now contains all connection info needed to interact with the cluster
sc <- spark_connect(master = "local")

# Read in the chembl_mols csv file
chembl_tbl <- spark_read_csv(sc,
                             "chembl",
                             "chembl_mols.csv",
                             # Note: not commas, it's actually semicolons!
                             delimiter = ";"
                             )

chembl_tbl

# Trial using dyplr to wrangle data!
# e.g. filter out all small molecules with max phase of 4
library(tidyverse)
chembl_4 <- chembl_tbl %>% 
  filter(Max_Phase == 4) %>% 
  select(Molecular_Weight, Rotatable_Bonds)

# Remove NAs


chembl_4


library(ggplot2)
ggplot(chembl_4, aes(Molecular_Weight, 
                     Rotatable_Bonds, 
                     colour = Rotatable_Bonds)) + 
  geom_point()


# Disconnect from Spark
# spark_disconnect() will shut down single node Spark environment in the machine 
# & inform R the connection is no longer valid
spark_disconnect(sc)