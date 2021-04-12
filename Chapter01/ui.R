library(shiny)
library(shinydashboard)

fluidPage(

    tags$head(
        tags$style(HTML(
            "h3 {
                color: blue;font-family:courier;
                text-decoration: underline;
            }"
        ))
    ),

    includeCSS(paste0(getwd(), "/www/styles.css")),

    titlePanel("IMDB Movie Explorer"),

    ## At request-time, server.R/ui.R has no idea of
    ## what the frontend DOM structure looks like so...

    sidebarLayout(
        sidebarPanel(
            h1("Report Controls",
                style = "color:red; font-family:Impact, Charcoal, sans-serif;"),

            textInput(inputId = "title", label = "Title"),

            h4("Budgets over time"),
            selectInput(inputId = "genre", label = "Which genre?",
                c("Action", "Animation", "Comedy", "Drama",
                    "Documentary", "Romance", "Short")),

            h4("Movie Picker"),
            uiOutput(outputId = "listMovies"),

            sliderInput("year", "Years", min = 1893, max = 2005,
                value = c(1945, 2005), sep = "")
        ),

        mainPanel(
            tabsetPanel(
                tabPanel(
                    "Budgets over time",
                    plotOutput("budgetYear"),
                    p(
                        "For more information about ",
                        strong("Shiny"), " look at the ",
                        a(href = "http://shiny.rstudio.com/articles/", "documentation.")
                    ),
                    hr(),
                    h3("Some code goes under here"),
                    p(
                        "If you wish to write some code you may like
                        to use the pre() function like this:",
                        pre(
                            'sliderInput("year", "Year", min = 1893, max = 2005, value = c(1945, 2005), sep = "")'
                        )
                    )
                ),
                tabPanel("Movie picker", tableOutput("moviePicker"))
            )
        )
    )
)
