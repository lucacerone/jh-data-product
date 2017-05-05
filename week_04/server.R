library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(shinythemes)
library(plotly)

shinyServer( function(input, output, session){
  dataset <- reactive({
    if (input$dataset == 'iris') {
      return(iris)
    } else if (input$dataset == 'mtcars') {
      return(mtcars) 
    } else if (input$dataset == 'USArrests') {
      return(USArrests)
    }
  })
  
  columns <- reactive({
    cols <- colnames(dataset())
    is_numeric <- sapply(dataset(),is.numeric)
    cols[is_numeric]
  })
  
  observeEvent(columns(),
               updateSelectInput(session, 'var_x', choices = columns(), selected = columns()[1])
  )
  
  observeEvent(columns(),
               updateSelectInput(session, 'var_y', choices = columns(), selected = columns()[2])
  )
  
  selected <- reactive({
    req(input$var_x %in% colnames(dataset()))
    req(input$var_y %in% colnames(dataset()))
    
    d <- dataset()[ c(input$var_x, input$var_y )]
    colnames(d) <- c('x','y')
    return(d)
  })
  
  output$prediction <- renderPlotly({
    req(selected())
    plot_ly(selected(), x = ~x, y = ~y, type = 'scatter', mode = "markers")
  })
})

