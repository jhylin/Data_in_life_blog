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

# Data wrangling
# Import tidyverse
library(tidyverse)
# Filter out all small molecules with max phase of 4
chembl_4 <- chembl_tbl %>% 
  filter(Max_Phase == 4 & Type == "Small molecule") %>% 
  # Select physicochemical features to visualise correlations
  # Number of aromatic rings and targets
  select(Max_Phase, Type, Aromatic_Rings, Targets, RO5_Violations)

# Remove NAs

# View wrangled dataset
view(chembl_4)

library(ggplot2)
ggplot(chembl_4, aes(Aromatic_Rings, Targets)) + 
  geom_point(na.rm = TRUE)
  #coord_flip()


chembl_all <- chembl_tbl %>% 
  filter(Type == "Small molecule") %>% 
  # Select physicochemical features to visualise correlations
  select(Max_Phase, Type, Aromatic_Rings, Targets, RO5_Violations)

ggplot(chembl_all, aes(Aromatic_Rings, Targets)) + 
  geom_point() +
  facet_grid(rows = vars(Max_Phase))
#coord_flip()


# Disconnect from Spark
# spark_disconnect() will shut down single node Spark environment in the machine 
# & inform R the connection is no longer valid
spark_disconnect(sc)