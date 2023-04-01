# Shiny app producing boxplots via ggplot2's geom_boxplot()

library(shiny)
library(tidyverse)
library(ggplot2)

# Define UI for app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Small molecules in ChEMBL database"),
  
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
      # Output: Lollipop Plot ----
      plotOutput(outputId = "BPlot")
      
    )
  )
)

# Define server logic ----
server <- function(input, output) {
  
  # render* function in server to tell Shiny how to build objects
  # Surround R expressions by {} in each render* function
  # Save render* expressions in the output list, with one entry for 
  # each reactive object in the app
  # Create reactivity by including an input value in a render* expression
  
  # Sample code from widget gallery
  output$BPlot <- renderPlot({ 
    
    ggplot(chembl, aes(chembl$`Max Phase`, .data[[input$variable]])) +
      geom_boxplot(aes(group = cut_width(`Max Phase`, 0.25), 
                       colour = `Max Phase`), outlier.alpha = 0.2)
    
    }, res = 96)
  
  
}

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)

