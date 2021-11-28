library(shiny)
ui <- fluidPage(
  tabsetPanel(type = "tabs",
              tabPanel("Sentiment Analysis", 
                       textInput("typedInput", "", value = "", width = "400px", placeholder = "Enter text to be analyzed here..."),
                       actionButton("analyzeButton", "Analyze"),
                       actionButton("fileInput", "Analyze file"),
                       sidebarLayout(
                         
                         sidebarPanel(
                           "Confidence Level: ", textOutput("confidence", inline = FALSE),
                           fileInput("file1", "Choose File",
                                     multiple = TRUE,
                                     accept = c("text/csv",
                                                "text/comma-separated-values,text/plain",
                                                ".csv")),
                         ),
                         mainPanel(
                           "Output Emoji: ", textOutput("emoji", inline = FALSE)
                         ),
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
  emoji <- eventReactive(input$file1, {
    runif(input$file1)
  })
  output$files <- renderTable(input$file1)
}

shinyApp(ui = ui, server = server)

#runExample("06_tabsets")