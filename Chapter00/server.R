library(coriverse)
library(shiny)
library(shinydashboard)
library(shinylogs)

LOG_FILE <- 'logs'

if (!dir.exists("logs")) {
  dir.create("logs")
}

function(input, output, session) {

  track_usage(storage_mode = store_json(path = "logs/"))

  # Return the components of the URL in a string:
  output$urlText <- renderText({
    paste(sep = "",
          "protocol: ", session$clientData$url_protocol, "\n",
          "hostname: ", session$clientData$url_hostname, "\n",
          "pathname: ", session$clientData$url_pathname, "\n",
          "port: ",     session$clientData$url_port,     "\n",
          "search: ",   session$clientData$url_search,   "\n",
          "token: ",   session$token,   "\n",
          "app-token: ",   session$options$appToken,   "\n"
    )
  })

  # Parse the GET query string
  output$queryText <- renderText({
    query <- parseQueryString(session$clientData$url_search)

    # Return a string with key-value pairs
    paste(
      names(query),
      sapply(query, function(q) {
          if (grepl(",", q))
            unlist(strsplit(q, split=","))
          else q
      }), sep = "=", collapse=", ")
  })
}
