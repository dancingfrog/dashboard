library(ggplot2movies)
library(rlang)
library(scales)
library(tidyverse)

function(input, output) {

  moviesSubset <- reactive({

    movies %>% filter(year %in% seq(input$year[1], input$year[2]),
        UQ(sym(input$genre)) == 1)

  })

  output$budgetYear <- renderPlot({

    budgetByYear <- moviesSubset() %>%
        group_by(year) %>%
        summarise(m = mean(budget, na.rm = TRUE))

    ggplot(budgetByYear[complete.cases(budgetByYear), ],
        aes(x = year, y = m)) +
        geom_line() +
        scale_y_continuous(labels = scales::comma) +
        geom_smooth(method = "loess") +
        ggtitle(input$title)

  })

  output$listMovies <- renderUI({

    selectInput("pickMovie", "Pick a movie",
        choices = moviesSubset() %>%
            sample_n(10) %>%
            select(title)
    )
  })

  output$moviePicker <- renderTable({

    if(is.null(input$pickMovie)) {
      return()
    } else {
      filter(moviesSubset(), title == input$pickMovie)
    }

  })

}
