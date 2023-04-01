library(tidyverse)
library(ggplot2)

# Using the condensed or subset of the original chembl_mols.csv dataset
chembl <- read_csv("chembl_m.csv")

head(chembl)

# Quick look at all columns names, data types & variables
glimpse(chembl)

# Initial code using chembl data to plot boxplot to observe data distributions
# df_QED_MP <- chembl %>% 
#   select(`Max Phase`, `QED Weighted`) %>% 
#   ggplot(aes(x = `Max Phase`, y = `QED Weighted`)) +
#   geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25)))
# 
# df_QED_MP

# Intending to observe different physicochemical features in small molecules
# in different max phases so to avoid copying-and-pasting code over and over,
# use a function instead:

# Boxplot function to plot Max Phase against other physicochemical properties

dfBoxplot <- function(var) {
  label <- rlang::englue("{{var}} vs. Max Phases of small molecules")
  
  chembl %>% 
    select(`Max Phase`, {{ var }}) %>% 
    ggplot(aes(x = `Max Phase`, y = {{ var }})) +
    geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25), 
                     colour = `Max Phase`), 
                 outlier.alpha = 0.2) +
    labs(title = label)
}

# Potentially add physicochemical properties below into drop-down box in app
# Max phase vs. MW
dfBoxplot(`Molecular Weight`)

# Max phase vs. AlogP
dfBoxplot(AlogP)

# Max phase vs. QED weighted scores
dfBoxplot(`QED Weighted`)

# Max phase vs. Polar surface area
dfBoxplot(`Polar Surface Area`)

# Max phase vs. Aromatic rings
dfBoxplot(`Aromatic Rings`)

# Max phase vs. #RO5 Violations
dfBoxplot(`#RO5 Violations`)

# Max phase vs. HBA
dfBoxplot(HBA)
