library(shiny)
library(shinyjs)


ui <- fluidPage(
  shinyjs::useShinyjs(),
  tags$head(
    tags$style(HTML("
                    .checkbox input  {
                        display: none;
                    }
                    
                    .checkbox label {
                      font-weight:bold;
                    }
                    
                    .checkbox span:before {
                      content:'✔  ';
                      color:#169116;
                      font-size: 1.5rem;
                    }
                    
                    .unchecked + span:before {
                      content: '✖ ' !important;
                      color:#ff0000;
                      font-size: 1.5rem;
                      font-weight:normal;
                      opacity: 0.5;
                    }
                    
                    .unchecked + span {
                      opacity: 0.5;
                      font-weight:normal;
                    }
                    
                    ")
    )
  ),
  
  column(6,
         h2('Individual checkbox'),
         checkboxInput('option_1', 'Option 1', value = TRUE),
         checkboxInput('option_2', 'Option 2', value = TRUE),
         checkboxInput('option_3', 'Option 3', value = TRUE),
         hr(),
         
         verbatimTextOutput('valor')
  ),
  column(6,
         checkboxGroupInput('check_group', h2('Group checkbox'), choices = ''),
         hr(),
         verbatimTextOutput('valor_group')
  )
)

server <- function(input, output, session) {
  output$valor <- renderPrint({
    glue::glue(
      "Option 1: {input$option_1}
       Option 2: {input$option_2}
       Option 3: {input$option_3}"
    )
  })
  
  output$valor_group <- renderPrint({
    input$check_group
  })
  
  toggle_effect_individual <- function(inpt,id) {
    if (!inpt) {
      shinyjs::addClass(id = id, class = 'unchecked')
    } else {
      shinyjs::removeClass(id = id, class = 'unchecked')
    }
  }
  
  observeEvent(input$option_1, { toggle_effect_individual(input$option_1, "option_1") })
  observeEvent(input$option_2, { toggle_effect_individual(input$option_2, "option_2") })
  observeEvent(input$option_3, { toggle_effect_individual(input$option_3, "option_3") })
  
  input_choices <- c('Option 1','Option 2','Option 3')
  updateCheckboxGroupInput(inputId = 'check_group', choices = input_choices, selected = input_choices)
  
  observe({
    
    checked <- which(input_choices %in% input$check_group)-1
    unchecked <- 0:(length(input_choices)-1) 
    unchecked <- jsonlite::toJSON(unchecked[!unchecked %in% checked])
    checked <- jsonlite::toJSON(checked)
    
    if (is.null(input$check_group)) {
      unchecked <- jsonlite::toJSON(0:(length(input_choices)-1))
    } else {
      shinyjs::runjs(glue::glue("
        var checked = {checked};
        checked.map((i) => document.querySelectorAll('#check_group input')[i].classList.remove('unchecked'));
      "))
    }
    
    shinyjs::runjs(glue::glue("
    var unchecked = {unchecked};
    unchecked.map((i) => document.querySelectorAll('#check_group input')[i].classList.add('unchecked'));
               "))
    
  })
  

    
  
}

shinyApp(ui, server)