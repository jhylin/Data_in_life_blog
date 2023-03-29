library(tidyverse)
library(ggplot2)

# Using the condensed or subset of the original chembl_mols.csv dataset
chembl <- read_csv("chembl_mols_new.csv")

head(chembl)

# Quick look at all columns names, data types & variables
glimpse(chembl)

# Initial code using chembl data to plot boxplot to observe data distributions
df_QED_MP <- chembl %>% 
  select(`Max Phase`, `QED Weighted`) %>% 
  ggplot(aes(x = `Max Phase`, y = `QED Weighted`)) +
  geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25)))

df_QED_MP

# Intending to observe different physicochemical features in small molecules
# in different max phases so to avoid copying-and-pasting code over and over,
# use a function instead:

# Boxplot function to plot Max Phase against other physicochemical properties

# Example from R4DS
# conditional_bars <- function(df, condition, var) {
#   df |> 
#     filter({{ condition }}) |> 
#     ggplot(aes(x = {{ var }})) + 
#     geom_bar()
# }
# 
# diamonds |> conditional_bars(cut == "Good", clarity)

dfBoxplot <- function(df, var) {
  df %>% 
    select(`Max Phase`, {{ var }}) %>% 
    ggplot(aes(x = `Max Phase`, y = {{ var }})) +
    geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25)), outlier.alpha = 0.2)
}

# Max phase vs. MW
chembl %>% dfBoxplot(`Molecular Weight`)

# Max phase vs. AlogP
chembl %>% dfBoxplot(AlogP)

# Max phase vs. QED weighted scores
chembl %>% dfBoxplot(`QED Weighted`)

# Max phase vs. Polar surface area
chembl %>% dfBoxplot(`Polar Surface Area`)

# Max phase vs. Aromatic rings
chembl %>% dfBoxplot(`Aromatic Rings`)

# Max phase vs. #RO5 Violations
chembl %>% dfBoxplot(`#RO5 Violations`)

# Max phase vs. HBA
chembl %>% dfBoxplot(HBA)
