library(ggplot2movies)
library(rlang)
library(scales)
library(shiny)
library(shinydashboard)
library(tidyverse)

boxxy <- function(title, value, color = "#ef476f", animate = TRUE){
  list(
      title = title, value = value, color = color, animate = animate
  )
}

renderBoxxy <- function(expr, env = parent.frame(),
    quoted = FALSE) {
  # Convert the expression + environment into a function
  render_func <- shiny::exprToFunction(expr, env, quoted)

  return(render_func)
}

function(input, output, session) {

  report_title <- reactive(input$title)

  output$customOutput <- renderBoxxy({
    boxxy(title = report_title()[1], value = 9500, color = "#ef476f", animate = FALSE)
  })

  # Return the components of the URL in a string:
  output$urlText <- renderText({
    result <- paste0(sep = "",
          "protocol: ", session$clientData$url_protocol, "\n",
          "hostname: ", session$clientData$url_hostname, "\n",
          "pathname: ", session$clientData$url_pathname, "\n",
          "port: ",     session$clientData$url_port,     "\n",
          "search: ",   session$clientData$url_search,   "\n"
    )
    return(result)
  })

  # Parse the GET query string
  output$queryText <- renderText({
    query <- parseQueryString(session$clientData$url_search)

    # Return a string with key-value pairs
    result <- paste(
      names(query),
      sapply(query, function(q) {
          if (grepl(",", q))
            unlist(strsplit(q, split=","))
          else q
      }), sep = "=", collapse=", ")
    return(result)
  })

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
        ggtitle(report_title()[1])

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
