library(shiny)
library(emojifont)
library(sentimentr)
library(devtools)
devtools::install_github("hadley/emo")

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
                           "Output Emoji: ", textOutput("emoji", inline = FALSE),
                           "Sentiment Score: ", textOutput("score", inline = FALSE)
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
  #choose a happy emoji

  
  output$files <- renderTable(input$file1)
  
  observeEvent(input$analyzeButton, {
    print(input$typedInput)
    sentdf<-sentiment_by(input$typedInput, by = NULL)
    print(sentdf[[4]])
    sentScore <- sentdf[[4]]
    # print(typeof(sentScore))
    # list1 <- search_emoji('smile')
    # emj <- sample(list1, 1)
    # print(emj)
    # output$emoji <-renderText({emojifont::emoji(emj)})
    if (sentScore > 0.75) {
      output$emoji <-renderText({emo::ji("happy")})
    } else if (sentScore > 0.5) {
      output$emoji <-renderText({emo::ji("joy")})
    } else if (sentScore > 0.25) {
      output$emoji <-renderText({emo::ji("smile")})
    } else if (sentScore > 0) {
      output$emoji <-renderText({emo::ji("eye")})
    } else if (sentScore == 0) {
      output$emoji <-renderText({emo::ji("number")})
    } else if (sentScore > -0.25) {
      output$emoji <-renderText({emo::ji("face")})
    } else if (sentScore > -0.5) {
      output$emoji <-renderText({emo::ji("indifference")})
    } else if (sentScore > -0.75) {
      output$emoji <-renderText({emo::ji("sad")})
    } else if (sentScore > -1.001) {
      output$emoji <-renderText({emo::ji("oops")})
    }
    
    
    
    
    
    output$score <-renderText({sentScore})
  })
  # score<- eventReactive(input$analyzeButton{
  #   input$typedInput
  # })
  # output$score <-renderText({})
  

}

shinyApp(ui = ui, server = server)

#runExample("06_tabsets")