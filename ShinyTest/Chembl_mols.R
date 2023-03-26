# import sparklyr package
library(sparklyr)

# Check for available versions of Spark
spark_available_versions()

# install Spark locally
spark_install(version = 3.3)

# Connect to Spark
# spark_connect is able to start & connect to the single node Spark cluster on our machines
# note: sc variable now contains all connection info needed to interact with the cluster
sc <- spark_connect(master = "local")





# Disconnect from Spark
# spark_disconnect() will shut down single node Spark environment in the machine 
# & inform R the connection is no longer valid
spark_disconnect(sc)