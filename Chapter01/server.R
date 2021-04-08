library(shiny)
library(ggplot2movies)
library(tidyverse)
library(scales)

library(rlang)

function(input, output) {

  addResourcePath("app", paste0(getwd(), "/www"))

  addResourcePath("html", paste0(getwd(), "/www"))

  moviesSubset <- reactive({

    movies %>% filter(UQ(sym(input$genre)) == 1)

  })

  output$budgetYear <- renderPlot({

    budgetByYear <- moviesSubset() %>%
        group_by(year) %>%
        summarise(m = mean(budget, na.rm = TRUE))

    ggplot(budgetByYear[complete.cases(budgetByYear),],
        aes(x = year, y = m)) +
        geom_line() +
        scale_y_continuous(labels = scales::comma) +
        geom_smooth(method = "loess") +
        ggtitle(input$title)

  })

  output$listMovies <- renderUI({
    selectInput(
        inputId = "selectMovie",
        label = "Pick a movie",
        choices = moviesSubset() %>%
            sample_n(10) %>%
            select(title)
    )
  })

  output$moviePicker <- renderTable({

    if (is.null(input$pickMovie)) return()

    filter(moviesSubset(), title == input$pickMovie)

  })

}
