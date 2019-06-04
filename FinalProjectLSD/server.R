library(shiny)
library(dplyr)
library(stringr)
library(ggplot2)
library(markdown)

movieData <- read.csv("./data/tmdb_5000_movies.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # Reactive expressions created in order to paste statistics to plots
    plot1DataText <- reactive({
        movieData %>%
            filter(str_detect(genres, input$plot1Select)) %>%
            select(c(genres, revenue))
    })
    
    plot2DataText <- reactive({
        movieData %>%
            filter(str_detect(genres, input$plot2Select)) %>%
            select(c(genres, vote_average))
    })
    
    plot3DataText <- reactive({
        movieData %>%
            filter(str_detect(genres, input$plot3Select)) %>%
            select(c(genres, budget))
    })

    output$plot1 <- renderPlot({
        plot1Data <- movieData %>% 
            filter(str_detect(genres, input$plot1Select)) %>% 
            select(c(genres, revenue))
        plot1Min <- min(plot1Data$revenue)
        plot1Max <- max(plot1Data$revenue)
        plot1Mean <- mean(plot1Data$revenue)
        plot1Title <- c(paste0(input$plot1Select, ", Min"), 
                        paste0(input$plot1Select, ", Max"), 
                        paste0(input$plot1Select, ", Mean"))
        plot1Values <- c(plot1Min, plot1Max, plot1Mean)
        plot1df <- data.frame(plot1Title, plot1Values)
        plot1df %>%
            ggplot(aes(x = plot1Title, y = signif((plot1Values / 1000000), digits = 3))) +
            geom_bar(fill = "cadetblue1", color = "black", alpha = 0.8, stat = "identity") +
            labs(x = "Genre", y = "Revenue (Millions of USD)")

    })
    
    output$plot2 <- renderPlot({
        plot2Data <- movieData %>% 
            filter(str_detect(genres, input$plot2Select)) %>% 
            select(c(genres, vote_average))
        plot2Min <- min(plot2Data$vote_average)
        plot2Max <- max(plot2Data$vote_average)
        plot2Mean <- mean(plot2Data$vote_average)
        plot2Title <- c(paste0(input$plot2Select, ", Min"), 
                        paste0(input$plot2Select, ", Max"), 
                        paste0(input$plot2Select, ", Mean"))
        plot2Values <- c(plot2Min, plot2Max, plot2Mean)
        plot2df <- data.frame(plot2Title, plot2Values)
        plot2df %>%
            ggplot(aes(x = plot2Title, y = plot2Values)) +
            geom_bar(fill = "coral2", color = "black", alpha = 0.8, stat = "identity") +
            labs(x = "Genre", y = "Average Rating received (0 - 10 scale)")
    })
    
    output$plot3 <- renderPlot({
        plot3Data <- movieData %>% 
            filter(str_detect(genres, input$plot3Select)) %>% 
            select(c(genres, budget))
        plot3Min <- min(plot3Data$budget)
        plot3Max <- max(plot3Data$budget)
        plot3Mean <- mean(plot3Data$budget)
        plot3Title <- c(paste0(input$plot3Select, ", Min"), 
                        paste0(input$plot3Select, ", Max"), 
                        paste0(input$plot3Select, ", Mean"))
        plot3Values <- c(plot3Min, plot3Max, plot3Mean)
        plot3df <- data.frame(plot3Title, plot3Values)
        plot3df %>%
            ggplot(aes(x = plot3Title, y = signif((plot3Values / 1000000), digits = 3))) +
            geom_bar(fill = "aquamarine1", color = "black", alpha = 0.8, stat = "identity") +
            labs(x = "Genre", y = "Budget Received (Millions of USD)")
    })
    
    output$plot4 <- renderPlot({
        
    })
    
    output$p1Text <- renderText({
        
    })
    
    output$p2Text <- renderText({
        
    })
    
    output$p3Text <- renderText({
        
    })
    
    output$p4Text <- renderText({
        
    })
    
    output$aboutText <- renderText({
        
    })

})
