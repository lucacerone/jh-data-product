library(shiny)
library(miniUI)

myGadgetFunc <- function(inputValue1, inputValue2) {
  
  ui <- miniPage(
    gadgetTitleBar("My Gadget"),
    miniContentPanel(
      # Define layout, inputs, outputs
    )
  )
  
  server <- function(input, output, session) {
    # Define reactive expressions, outputs, etc.
    
    # When the Done button is clicked, return a value
    observeEvent(input$done, {
      returnValue <- 0
      stopApp(returnValue)
    })
  }
  
  runGadget(ui, server)
}


multiplyGadget <- function(numbers1, numbers2) {
  ui <- miniPage(
    gadgetTitleBar('multiply'),
    miniContentPanel(
      selectInput("num1", "First Number", choices = numbers1),
      selectInput("num2", "Second Number",choices = numbers2)
    )
  )
  
  server <- function(input, output, session) {
    observeEvent(input$done,{
      num1 <- as.numeric(input$num1)
      num2 <- as.numeric(input$num2)
      stopApp(num1*num2)
    })
  }
  
  runGadget(ui, server)
}


library(shiny)
library(miniUI)

pickXY <- function() {
  ui <- miniPage(
    gadgetTitleBar("Select Points by Dragging your Mouse"),
    miniContentPanel(
      plotOutput("plot", height = "100%", brush = "brush")
    )
  )
  
  server <- function(input, output, session) {
    output$plot <- renderPlot({
      plot(data_frame$X, data_frame$Y, main = "Plot of Y versus X",
           xlab = "X", ylab = "Y")
    })
    observeEvent(input$done, {
      stopApp(brushedPoints(data_frame, input$brush,
                            xvar = "X", yvar = "Y"))
    })
  }
  
  runGadget(ui, server)
}

my_data <- data.frame(X = rnorm(100), Y = rnorm(100))

pickXY(my_data)
