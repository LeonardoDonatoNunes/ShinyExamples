library(shiny)
library(shinyjs)

options(shiny.launch.browser = TRUE)

ui <- fluidPage(

  shinyjs::useShinyjs(),
  textInput("text_input", label = h3("Text input")),
  hr(),
  
  fluidRow(column(3, verbatimTextOutput("value")))  
)

server <- function(input, output, session) {
  
  shinyjs::runjs("
  var input_content = document.getElementById('text_input')
  var timeout = null;
  input_content.addEventListener('input', function(event) {
  clearTimeout(timeout);
  timeout = setTimeout(function () {
      Shiny.onInputChange('text_input_timeout',
                         {value:input_content.value});
    }, 1000); });
  ")
  
  output$value <- renderPrint({
    input$text_input_timeout$value
  })
  
}

shinyApp(ui, server)