# chembl_mols.csv file size actually can be handled with tidyverse 
# without the need of sparklyr

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

spec_with_chem <- sapply(read.csv("chembl_mols.csv", nrows = 10), class)
spec_with_chem

# Read in the chembl_mols csv file
#iris_csv_tbl <- spark_read_csv(sc, "iris_csv", temp_csv)
chembl_tbl <- spark_read_csv(sc, 
                             "chembl", 
                             "chembl_mols.csv", 
                             columns = spec_with_chem
                             )

chembl_tbl


# Disconnect from Spark
# spark_disconnect() will shut down single node Spark environment in the machine 
# & inform R the connection is no longer valid
spark_disconnect(sc)