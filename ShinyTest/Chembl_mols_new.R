library(tidyverse)
library(ggplot2)

chembl <- read_csv("chembl_mols_new.csv")

head(chembl)

colnames(chembl)

glimpse(chembl)

spec(chembl)

# Initial code to use a subset of chembl data to plot boxplot 
# to observe data distributions
df_QED_MP <- chembl %>% 
  select(`Max Phase`, `QED Weighted`) %>% 
  ggplot(aes(x = `Max Phase`, y = `QED Weighted`)) +
  geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25)))

df_QED_MP

# Intending to observe different physicochemical features in small molecules
# in different max phases so to avoid copying-and-pasting code over and over
# Use a function instead as shown below

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
  df |>
    select(`Max Phase`, {{ var }}) |>
    ggplot(aes(x = `Max Phase`, y = {{ var }})) +
    geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25)), outlier.alpha = 0.2)
}

# Max phase vs. MW
chembl |> dfBoxplot(`Molecular Weight`)

# Max phase vs. AlogP
chembl |> dfBoxplot(AlogP)

# Max phase vs. QED weighted scores
chembl |> dfBoxplot(`QED Weighted`)

# Max phase vs. Polar surface area
chembl |> dfBoxplot(`Polar Surface Area`)
