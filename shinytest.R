library(shiny)
ui <- fluidPage(
  tabsetPanel(type = "tabs",
              tabPanel("Sentiment Analysis", 
                       textInput("typedInput", "", value = "", width = "400px", placeholder = "Enter text to be analyzed here..."),
                       actionButton("analyzeButton", "Analyze"),
                       actionButton("fileInput", "Import a file..."),
                       sidebarLayout(
                         sidebarPanel(
                           "Confidence Level: ", textOutput("confidence", inline = FALSE)
                         ),
                         mainPanel(
                           "Output Emoji: ", textOutput("emoji", inline = FALSE)
                         )
                       ),
                       headerPanel("Visualizations:"),
                       "Awaiting input..."
                       ),
              tabPanel("Design", "Design will go here! With charts and images."),
              tabPanel("Acknowledgements", "Acknowledgements will go here!"),
              tabPanel("Reflection", "Reflection will go here!")
  ),
  
)

server <- function(input, output, session) {
  # the modal dialog where the user can enter the query details.
  #query_modal <- modalDialog(
  #  title = "Welcome to our project!",
  #  easyClose = F,
  #  footer = tagList(
  #    actionButton("run", "Close")
  #  )
  #)
  
  
  # Show the model on start up ...
  #showModal(query_modal)
  
  
  # ... or when user wants to change query
  #observeEvent(input$change,
  #             {
  #               showModal(query_modal)
  #             })
  
  # reactiveVal to store the dataset

  
}

shinyApp(ui = ui, server = server)

#runExample("06_tabsets")