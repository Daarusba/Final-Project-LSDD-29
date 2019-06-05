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

    # A simple bar plot that gives a visual comparison between the minimum,
    # maximum, and mean revenue of a single genre of film. Basic summary
    # statistic are then provided.
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
            ggplot(aes(x = plot1Title, y = signif((plot1Values / 1000000),
                                                  digits = 3))) +
            geom_bar(fill = "cadetblue1", color = "black", alpha = 0.8,
                     stat = "identity") +
            labs(x = "Genre", y = "Revenue (Millions of USD)")

    })
    
    # A simple bar plot that gives a visual comparison between the minimum,
    # maximum, and mean, average review score of a single genre of film. Basic summary
    # statistic are then provided.
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
            geom_bar(fill = "coral2", color = "black", alpha = 0.8,
                     stat = "identity") +
            labs(x = "Genre", y = "Average Rating received (0 - 10 scale)")
    })
    
    # A simple bar plot that gives a visual comparison between the minimum,
    # maximum, and mean budget of a single genre of film. Basic summary
    # statistic are then provided.
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
            ggplot(aes(x = plot3Title, y = signif((plot3Values / 1000000),
                                                  digits = 3))) +
            geom_bar(fill = "darkgoldenrod1", color = "black", alpha = 0.8,
                     stat = "identity") +
            labs(x = "Genre", y = "Budget Received (Millions of USD)")
    })
    
    # A scatter plot showing budget(x-axis) versus revenue(y-axis) of all of the
    # films used within the data set.
    output$plot4 <- renderPlot({
        plot4data <- movieData %>% 
            mutate(budget = signif(budget / 1000000, digits = 3), 
                   revenue = signif(revenue / 1000000, digits = 3)) %>% 
            filter(budget >= input$range[1], budget <= input$range[2])
        ggplot(plot4data, aes(x= budget, y= revenue)) +
            geom_point() +
            geom_smooth(method=lm) +
            labs(title = "Budget and Revenue Correlation", x = "Budget Rece
                 ived (Millions of USD)", y = "Revenue (Millions of USD)")
    })
    
    # Output text showing summary statistics on the revenue, rating, or
    # budget of a select genre.
    
    output$p1Text <- renderText({
        paste("The maximum revenue of this genre is",
              round(max(plot1DataText()$revenue)), "USD.", 
              "The mean revenue of this genre is", 
              round(mean(plot1DataText()$revenue)), "USD.", 
              "The minimum revenue of this genre is", 
              round(min(plot1DataText()$revenue)), "USD.")
    })
    
    output$p2Text <- renderText({
        paste("The maximum, average rating of this genre is",
              max(plot2DataText()$vote_average), "out of 10.", 
              "The mean, average rating of this genre is", 
              signif(mean(plot2DataText()$vote_average), digits = 2), "out of 10.", 
              "The minimum, average rating of this genre is", 
              min(plot2DataText()$vote_average), "out of 10.")
    })
    
    output$p3Text <- renderText({
        paste("The maximum budget of this genre is",
              signif(max(plot3DataText()$budget / 1000000), digits = 3),
              "million USD.", 
              "The mean budget of this genre is", 
              signif(mean(plot3DataText()$budget / 1000000), digits = 3),
              "million USD.", 
              "The minimum budget of this genre is", 
              signif(min(plot3DataText()$budget / 1000000), digits = 3),
              "million USD.")
    })


})
