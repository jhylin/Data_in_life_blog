# Shiny app producing boxplots via ggplot2's geom_boxplot()

# Load libraries
library(shiny)
library(vroom)
library(tidyverse)
library(ggplot2)

# Load ChEMBL dataset
chembl <- vroom("~/Data in life blog/ShinyAppChembl/chembl_m.csv")

# Define UI for app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Small molecules in ChEMBL database"),
  
  # Produce a markdown file with texts
  fluidRow(
    column(4,
           includeMarkdown("Chembl_intro.md")
    )
  ),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select box to choose physicochemical features
      selectInput("variable", "Choose a physicochemical property:", choices = setdiff(colnames(chembl), "Max Phase")),
      
    ),

    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # *Output function in ui to place reactive object in Shiny app
      # Output: Boxplot ----
      plotOutput(outputId = "BPlot")
      
    )
  )
)

# Define server logic ----
server <- function(input, output, session) {
  
  # Output showing boxplots of different physicochemical properties vs. max phases
  output$BPlot <- renderPlot({ 
    
    ggplot(chembl, aes(`Max Phase`, .data[[input$variable]])) +
      geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25), 
                       colour = `Max Phase`), outlier.alpha = 0.2) +
      labs(title = "Distributions of physicochemical properties against max phases",
           caption = "(based on ChEMBL database version 31)")
    
    }, res = 96) %>% bindCache(chembl$`Max Phase`, input$variable)
  
}

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)
