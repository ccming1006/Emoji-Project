library(shiny)
ui <- fluidPage(
  tabsetPanel(type = "tabs",
              tabPanel("Home", plotOutput("plot")),
              tabPanel("Sentiment Analysis", verbatimTextOutput("summary")),
              tabPanel("Design", tableOutput("table")),
              tabPanel("Acknowledgements", tableOutput("table")),
              tabPanel("Reflection", tableOutput("table"))
  )
)

server <- function(input, output, session) {
  # the modal dialog where the user can enter the query details.
  query_modal <- modalDialog(
    title = "Welcome to our project!",
    easyClose = F,
    footer = tagList(
      actionButton("run", "Close")
    )
  )
  
  
  # Show the model on start up ...
  showModal(query_modal)
  
  
  # ... or when user wants to change query
  observeEvent(input$change,
               {
                 showModal(query_modal)
               })
  
  # reactiveVal to store the dataset
  my_dataset <- reactiveVal()
  
  observeEvent(input$run, {
    removeModal()
    
    # Your query here
    my_data <- mtcars %>% filter(cyl %in% input$input_query)
    my_dataset(my_data)
    
  })
  
  # render the output
  output$my_table <- renderDataTable(my_dataset())
  
}

shinyApp(ui = ui, server = server)

#runExample("06_tabsets")