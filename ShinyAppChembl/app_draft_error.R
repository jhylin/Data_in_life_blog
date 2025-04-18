# Shiny app producing boxplots via ggplot2's geom_boxplot()

# Load libraries
library(shiny)
library(tidyverse)
library(ggplot2)

# Load ChEMBL dataset
chembl <- read_csv("chembl_m.csv")

# Define UI for app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Small molecules in ChEMBL database"),
  
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select box to choose physicochemical features
      selectInput("variable", "Variable:", choices = setdiff(colnames(chembl), "Max Phase")),
      
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
    
    ggplot(chembl, aes(`Max Phase`, input$variable)) +
      geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25), 
                       colour = `Max Phase`), outlier.alpha = 0.2)
    
    })
  
}

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)
