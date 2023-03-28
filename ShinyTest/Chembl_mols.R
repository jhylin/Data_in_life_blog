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
# Import tidyverse & ggplot2
library(tidyverse)
library(ggplot2)

# Check column names
colnames(chembl_tbl)

# **Show mean values of physicochemical properties for small molecules 
# in different max phases**

# Example of using stat_summary()
# ggplot(diamonds) + 
#   stat_summary(
#     aes(x = cut, y = depth),
#     fun.min = min,
#     fun.max = max,
#     fun = median
#   )

# Mean QED_weighted scores for each max phase
chembl_QedW <- chembl_tbl %>% 
  filter(Type == "Small molecule") %>% 
  group_by(Max_Phase) %>% 
  summarise(QED_Weighted_m = mean(QED_Weighted)) %>% 
  collect() %>% 
  ggplot(aes(Max_Phase, QED_Weighted_m)) + 
  geom_segment(aes(x = Max_Phase, xend = Max_Phase, y = 0, yend = QED_Weighted_m), colour = "dark blue") +
  geom_point(colour = "dark green") +
  coord_flip()

ggplot(chembl_QedW) + 
  stat_summary(
    aes(x = Max_Phase, y = QED_Weighted),
    fun.min = min,
    fun.max = max,
    fun = median
  )
  
chembl_QedW


# Mean polar surface areas for each max phase
chembl_PSA <- chembl_tbl %>% 
  filter(Type == "Small molecule") %>% 
  group_by(Max_Phase) %>% 
  summarise(Polar_Surface_Area_m = mean(Polar_Surface_Area)) %>% 
  collect() %>% 
  ggplot(aes(Max_Phase, Polar_Surface_Area_m)) + 
  geom_segment(aes(x = Max_Phase, xend = Max_Phase, y = 0, yend = Polar_Surface_Area_m), colour = "dark blue") +
  geom_point(colour = "dark green") +
  coord_flip()

chembl_PSA


# Mean MW for each max phase
chembl_MW <- chembl_tbl %>% 
  filter(Type == "Small molecule") %>% 
  group_by(Max_Phase) %>% 
  summarise(Molecular_Weight_m = mean(Molecular_Weight)) %>% 
  collect() %>% 
  ggplot(aes(Max_Phase, Molecular_Weight_m)) + 
  geom_segment(aes(x = Max_Phase, xend = Max_Phase, y = 0, yend = Molecular_Weight_m), colour = "dark blue") +
  geom_point(colour = "dark green") +
  coord_flip()

chembl_MW




# Trialling on whole set of chembl data (longer processing time)
# chembl_all <- chembl_tbl %>% 
#   filter(Type == "Small molecule") %>% 
#   # Select physicochemical features to visualise correlations
#   select(Max_Phase, Type, Aromatic_Rings, Targets, RO5_Violations)
# 
# ggplot(chembl_all, aes(Aromatic_Rings, Targets)) + 
#   geom_point() +
#   facet_grid(rows = vars(Max_Phase))
# #coord_flip()


# Disconnect from Spark
# spark_disconnect() will shut down single node Spark environment in the machine 
# & inform R the connection is no longer valid
spark_disconnect(sc)