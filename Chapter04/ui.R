library(shiny)
library(ggplot2movies)

ui <- htmlTemplate(
    "template.html",
    text = (function () {
      textInput("title", "Title")
    })(),
    comboBox = (function () {
      selectInput("genre", "Which genre?",
          c("Action", "Animation", "Comedy", "Drama",
              "Documentary", "Romance", "Short"))
    })(),
    listMovies = (function () {
      uiOutput(outputId = "listMovies")
    })(),
    slider = (function () {
      sliderInput("year", "Year", min = 1893, max = 2005,
          value = c(1945, 2005), sep = "")
    })(),
    thePlot = (function () {
      plotOutput("budgetYear")
    })(),
    queryText = (function () {
      # textOutput("queryText")
      verbatimTextOutput("queryText")
    })(),
    urlText = (function () {
      #textOutput("urlText")
      verbatimTextOutput("urlText")
    })()
)
