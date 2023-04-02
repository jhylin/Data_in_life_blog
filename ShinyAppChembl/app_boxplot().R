# Shiny app producing boxplots via boxplot() (S3 method only)

library(shiny)

chembl <- read_csv("chembl_m.csv")

# Define UI for app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel("Small molecules in ChEMBL database"),
  
    # Sidebar layout with input and output definitions ----
    sidebarPanel(
      
      # Input: Select box to choose physicochemical features
      # choices = names(chembl)
      selectInput("variable", "Choose a physicochemical property:", choices = setdiff(colnames(chembl), "Max Phase")),
    
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

server <- function(input, output) {
  
    output$chemblPlot <- renderPlot({
      
      boxplot(get(input$variable) ~ chembl$`Max Phase`, data = chembl)
      
      }, res = 96)
    
    # *****Change x-axis label to "Max Phases" & y-axis labels (?reactive)*****
    # *****Add plot title*****  
    
  
    }
  

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)
