library(shiny)

# Read dataset
dataset <- read.csv("data/data-CAOyC.csv")

# Transfer dataset into a matrix
rowName <- dataset[,1]
dataset <- dataset[,c(2:7)]
datasetMat <- data.matrix(dataset)
rownames(datasetMat) <- rowName

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Cost of Living"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("dimension", "Aspects of Cost:", 
                    choices=colnames(datasetMat)),
        hr(),
        helpText("Data from WSJ India.")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("barPlot")  
      )
      
    )
  )
)
