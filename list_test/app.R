#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

items <- c(
  "apple",
  "orange",
  "banana",
  "grapefruit"
)

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  uiOutput("ui")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  rv1 <- reactive("test value")
  reactiveItems <- reactive(
    items
  )
  output$ui <- renderUI(
    {
      fluidRow(
        tags$h1("Welcome!"),
        tags$ul(
          lapply(reactiveItems(), function(x) tags$li(x))
        ),
        tags$p(rv1())
      )
    }
  )
}

# Run the application 
shinyApp(ui = ui, server = server)
