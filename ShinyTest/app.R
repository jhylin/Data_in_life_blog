library(shiny)
library(tidyverse)
library(ggplot2)

chembl <- read_csv("chembl_mols_new.csv")


# Define UI for app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Small molecules in ChEMBL database"),
  
    # Sidebar layout with input and output definitions ----
    sidebarPanel(
      
      # Input: Select box to choose physicochemical features
    
      selectInput("variable", "Choose a physicochemical property:", choices = colnames(chembl)),
    
      # Input: Checkbox for choosing to include outliers or not ----
      #checkboxInput("outliers", "Show outliers", TRUE)
      
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


#chemblData$`Max Phase` <- factor(chemblData$`Max Phase`, labels = c("zero", "one", "two", "three", "four"))



server <- function(input, output) {
  

  # render* function in server to tell Shiny how to build objects
  # Surround R expressions by {} in each render* function
  # Save render* expressions in the output list, with one entry for 
  # each reactive object in the app
  # Create reactivity by including an input value in a render* expression

    # selectedData <- reactive({
    #   chembl %>% input$variable
    #   })

    output$chemblPlot <- renderPlot({
      
      boxplot(chembl[chembl$`Max Phase`, input$variable])
      
      })
      
      
    }
  

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)
