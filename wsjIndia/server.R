library(shiny)

# Read dataset
dataset <- read.csv("data/data-CAOyC.csv")

# Transfer dataset into a matrix
rowName <- dataset[,1]
dataset <- dataset[,c(2:7)]
datasetMat <- data.matrix(dataset)
rownames(datasetMat) <- rowName

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  # Fill in the spot we created for a plot
  output$barPlot <- renderPlot({
    
    # Render a barplot
    par(las=2)
    barplot(sort(datasetMat[,input$dimension]),
            col="skyblue",
            border=NA,
            main=input$dimension,
            xlab="Hour/Minute/Dollar",
            horiz=TRUE,
            cex.names=0.6
            )
  })
})