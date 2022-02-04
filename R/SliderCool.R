library(shiny)

ui <- fluidPage(
  tags$head(
    tags$style(HTML("
                    .slider_cool span.irs-grid,
                    .slider_cool span.irs-grid-text {
                      visibility: hidden !important;
                    }
                    
                    .slider_cool span.irs--shiny .irs-bar {
                        top: 25px;
                        height: 8px;
                        border-top: none;
                        border-bottom: none;
                        background: #2dd23b3b;
                    }
                    .slider_cool span.irs--shiny .irs-from, .irs--shiny .irs-to, .irs--shiny .irs-single {
                    
                        color: green;
                        text-shadow: none;
                        padding: 1px 3px;
                        background-color: transparent;
                        border-radius: 3px;
                        font-size: 12px;
                        line-height: 1.333;
                    }
                    
                    .slider_cool span.irs--shiny .irs-line {
                        top: 25px;
                        height: 8px;
                        background: linear-gradient(to bottom, #dedede -50%, #fff 150%);
                        background-color: #ededed;
                        border: none;
                        border-radius: 0px;
                    }
                  .slider_cool span.irs--shiny .irs-handle {
                        top: 20px;
                        width: 0;
                        height: 0;
                        border-left: 10px solid transparent;
                        border-right: 10px solid transparent;
                        border-top: 15px solid green;
                        background-color: transparent;
                        box-shadow: none;
                        border-radius: 0px;
                  }
                    .slider_cool span.irs--shiny .irs-min, .irs--shiny .irs-max {
                      top: 5px;
                      padding: 1px 3px;
                      text-shadow: none;
                      background:none;
                      font-size: 12px;
                      line-height: 1.333;
                    }
                  
                    .slider_cool span.irs--shiny .irs-handle:hover,
                    .slider_cool span.irs--shiny .irs-handle:active{
                        border-top: 15px solid #19d122;
                        background-color: transparent;
                  }
                    
                    "))
  ),
tags$body(
  column(6,
         tags$div(class = 'slider_cool', sliderInput('slider_input', 'Slider input custom', min = 0, max = 100, value = 50)),
         hr(),
         verbatimTextOutput('value_1')
         ),
  
  column(6,
         tags$div(class = 'slider_normal', sliderInput('slider_input_normal', 'Slider input normal', min = 0, max = 100, value = 50)),
         hr(),
         verbatimTextOutput('value_2')
         )
)
)

server <- function(input, output, session) {
  output$value_1 <- renderPrint({
    input$slider_input
  })  
  
  output$value_2 <- renderPrint({
    input$slider_input_normal
  })  
}

shinyApp(ui, server)