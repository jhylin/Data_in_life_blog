library(shiny)
source("Chembl_mols_Sparklyr_test.R")


# Define UI for app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Small molecules in ChEMBL database"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Select box to choose physicochemical features
      selectInput("Physicochemical properties", label = h3("Select box"), 
                  choices = list("QED weighted scores" = QED_Weighted, 
                                 "Polar surface area" = Polar_Surface_Area, 
                                 "Molecular weight" = Molecular_Weight), 
                  selected = QED_Weighted),
      
      # Input: Radio buttons to choose max phases ----
      # radioButtons("radio", label = h3("Max phase"),
      #              choices = list("phase 0" = 0, "phase 1" = 1, "phase 2" = 2, "phase 3" = 3, "phase 4" = 4), 
      #              selected = 0),
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # *Output function in ui to place reactive object in Shiny app
      # Output: Lollipop Plot ----
      plotOutput(outputId = "lolliPlot")
      
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
  output$lolliPlot <- renderPlot({ 
    
    #input$radio

    
    })
  
  # Sample app code starts here
  # output$distPlot <- renderPlot({
  #   
  #   # Insert dataset below?
  #   x    <- faithful$waiting
  #   bins <- seq(min(x), max(x), length.out = input$bins + 1)
  #   
  #   hist(x, breaks = bins, col = "#75AADB", border = "orange",
  #        xlab = "Waiting time to next eruption (in mins)",
  #        main = "Histogram of waiting times")
  #   
  # })
  
}

# Create/run Shiny app ----
shinyApp(ui = ui, server = server)

