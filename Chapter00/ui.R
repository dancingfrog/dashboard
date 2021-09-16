library(shinylogs)

if (!dir.exists("logs")) {
  dir.create("logs")
}

function () {

  use_tracking()

  dashboardPage(
    dashboardHeader(title="Query Parameters"),
    dashboardSidebar(),
    dashboardBody(
      h3("URL components"),
      verbatimTextOutput("urlText"),
      h3("Parsed query string"),
      verbatimTextOutput("queryText")
    )
  )
}
