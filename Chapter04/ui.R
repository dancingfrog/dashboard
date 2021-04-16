library(shiny)
library(ggplot2movies)

boxxyOutput <- function(id){
  class <- "boxxy"
  title <- h1(
      id = sprintf("%s-boxxy-title", id),
      class = "boxxy-title"
  )
  body <- p(
      id = sprintf("%s-boxxy-counter", id),
      class = "boxxy-value"
  )

  el <- tags$div(id = id, class = class, title, body)

  # get full path
  path <- normalizePath("assets")

  deps <- list(
      htmltools::htmlDependency(
          name = "boxxy",
          version = "1.0.0",
          src = c(file = path),
          script = c("binding.js", "countUp.js"),
          stylesheet = "styles.css"
      )
  )

  htmltools::attachDependencies(el, deps)
}

ui <- htmlTemplate(
    "template.html.R",
    customOutput = (function () {
      boxxyOutput("customOutput")
    })(),
    text = (function () {
      textInput("title", "Title", "Custom Output")
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
