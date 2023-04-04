# Shiny app producing boxplots via boxplot() (S3 method only)

library(shiny)
library(tidyverse)

chembl <- read_csv("chembl_m.csv")

# Define UI for app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Small molecules in ChEMBL database"),
  
    # Sidebar layout with input and output definitions ----
    sidebarPanel(
      
      # Input: Select box to choose physicochemical features
      # choices = names(chembl)
      selectInput("variable", "Variable:", 
                  choices = setdiff(colnames(chembl), "Max Phase")),
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Formatted text for caption ----
      # h4(textOutput("caption")),
      
      # Output: Plot for the requested variable against max phases ----
      plotOutput("chemblPlot")
      
    )
  
)

# Define server logic ----

server <- function(input, output) {
  
    output$chemblPlot <- renderPlot({
      
      boxplot(get(input$variable) ~ chembl$`Max Phase`, data = chembl)
      
      }, res = 96)
    
  
    }
  

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)
