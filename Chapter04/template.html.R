<html lang="en">
  <head>
    <title>Minimal HTML UI</title>
    {{ headContent() }}
    {{ bootstrapLib() }}
  </head>
  <body>
    <h1>Minimal HTML UI</h1>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-4">
          <h3>Report Controls</h3>

          <!--<label for="movie-title">-->
          <!--  Title: <input id="movie-title" name="title" class="form-control" type="text"><br>-->
          <!--</label>-->
          {{ text }}

          <!--<div id="customOutput" class="boxxy shiny-bound-output">-->
          <!--  <h1 id="customOutput-boxxy-title" class="boxxy-title"></h1>-->
          <!--  <p id="customOutput-boxxy-counter" class="boxxy-value"></p>-->
          <!--</div>-->
          {{ customOutput }}

          <h4>Budgets over time</h4>
          {{ comboBox }}

          <h4>Movie Picker</h4>
          <!--div id="listMovies" class="shiny-html-output"></div-->
          {{ listMovies }}

          {{ slider }}

          <h4>URL components</h4>
          {{ urlText }}

          <h4>Parsed query string</h4>
          {{ queryText }}
        </div>

        <div class="col-sm-8">
            {{ thePlot }}
            <p>For more information about <strong>Shiny</strong> look at the <a href="http://shiny.rstudio.com/articles/">documentation.</a></p>
            <hr>  <p>If you wish to write some code you may like to
            use the pre() function like this:</p>
            <pre>sliderInput("year", "Year", min = 1893, max = 2005,
                     value = c(1945, 2005), sep = "")</pre>
          <div id = "moviePicker" class = "shiny-html-output"></div>
        </div>

      </div>
    </div>
  </body> 
</html>
