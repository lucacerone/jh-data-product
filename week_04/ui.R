library(shinythemes)
library(plotly)

fluidPage(
  theme = shinytheme("cerulean"),
  # Application title
  
  titlePanel("Datasets explorer!"),
  sidebarLayout(
    
    # Sidebar with a slider input
    sidebarPanel(
      div(
        selectInput("dataset", "choose a dataset", choices = c('iris','mtcars', 'USArrests')),
        selectInput("var_x", "Select x variable", choices = NA, multiple = FALSE),
        selectInput("var_y", "Select y variable", choices = NA, multiple = FALSE)
      ),
      div(
        h3('Instructions'),
        p("Using this dashboard you can select a dataset of your choice among 'iris',
'mtcars' and 'USArrests'."), 
        p("After selecting a dataset, you will be able to select any two among the numeric variables in the dataset and
          chose which one should be displayed on the x-axis and which one should be displayed on the y-axis"),
        p("The plot in the main panel will be updated to reflect your selection.")
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotlyOutput("prediction")
    )
    
  )
)
