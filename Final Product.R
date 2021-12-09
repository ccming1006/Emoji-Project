library(shiny)
library(emojifont)
library(sentimentr)
library(devtools)
devtools::install_github("hadley/emo")

ui <- fluidPage(
  tabsetPanel(type = "tabs",
              tabPanel("Sentiment Analysis", 
                       textInput("typedInput", "", value = "", width = "400px", placeholder = "Enter text to be analyzed here..."),
                       actionButton("analyzeButton", "Analyze sentence"),
                       textInput("ScoreInput", "", value = "", width = "400px", placeholder = "Enter a sentiment score here (-1,1)..."),
                       actionButton("analyzeScore", "Give me an emoji"),
                       sidebarLayout(
                         
                         sidebarPanel(
                         ),
                         mainPanel(
                           "Output Emoji: ", textOutput("emoji", inline = FALSE),
                           "Sentiment Score: ", textOutput("score", inline = FALSE)
                         ),
                       ),
              ),
              tabPanel("Design","Initially, we were planning to create an app that analyze the use of emojis in Twitter posts. 
                       However, we then realize that the opposite direction is more interesting—take the user input and generate a corresponding emoji. 
                       We begin our work by searching for resources and then we found the co-called “tidytext” library to conduct sentiment analysis in R. 
                       We when found several emoji dataset that we can use to relate to the sentiment score. 
                       In the next step, we split the work which one started to design the UI, one focused on the sentiment analysis, 
                       and the others worked on converting the sentiment score into emojis. 
                       The biggest challenge might be how to deal with different user inputs interactively. 
                       The library and functions we found only works for “static” data type that an interactive UI cannot provide. 
                       It took us a long time to figure out an alternative way to overcome this difficulty. 
                       We learned a lot by the process of problem solving in the software design: searching relevant information, 
                       use and combine different libraries and functions, and collaborate with peers and instructors."),
              tabPanel("Acknowledgements", "a.	We would like to thank Davin for providing the info about the NRC sentiment analysis database, 
                       and Professor Fernanda for the website of Text mining and the “Tidytext” library."),
              tabPanel("Reflection", "Our audience can be anyone who actively engage with social media every day. 
                       Since we usually use emoji to express our feelings, having such a generator can be very interesting. 
                       Also, as I mentioned above, we are trying to change the fact that people are limited to a small scope of emojis, 
                       providing them more choices with the sentiment analysis. This project aims to conduct sentiment analysis on user inputs, 
                       and then generates the corresponding emojis as the output. 
                       A higher vision for this project is that people often limited to a few frequently used emojis, 
                       and we hope to generate more emojis for the users to express their sentiments. We are probably the only group (this year) 
                       that do NOT take any dataset to analyze. Instead, we ask the user to give us the data, and we only search the user input 
                       in a sentiment database. Therefore, the interactive part is the user can type whatever sentence they want to analyze the 
                       sentiment. Then can even upload a file and we’ll analyze the sentiment of the entire file for you. It would be very 
                       interesting to see the output emoji with some weird inputs and play around with different sentiment scores. ")
  ),
)

server <- function(input, output, session) {

  
  observeEvent(input$analyzeButton, {
    sentdf<-sentiment_by(input$typedInput, by = NULL)
    sentScore <- sentdf[[4]]
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
  },)
  observeEvent(input$analyzeScore, {
    sentScore <- as.double(input$ScoreInput)
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
  },)

  
  
}

shinyApp(ui = ui, server = server)


#runExample("06_tabsets")