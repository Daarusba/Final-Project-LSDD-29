library(shiny)

CHOICE <- c("Action" = "Action", "Adventure" = "Adventure",
           "Comedy" = "Comedy", "Documentary" = "Documentary",
           "Drama" = "Drama", "Horror" = "Horror", "Romance" = "Romance",
           "Sci-Fi" = "Science Fiction", "Thriller" = "Thriller")
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Final Project"),
    
    # Sidebar with a slider input for number of bins
    navbarPage("Group LSD",
               tabPanel("Summary",
                        mainPanel(
                            textOutput("summaryText")
                        )
               ),
               tabPanel("Revenue",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput("plot1Select",
                                            label = h3("Select a Genre"),
                                            choices = CHOICE)
                            ),
                            mainPanel(
                                plotOutput("plot1")#,
                                # textOutput("p1Text")
                            )
                        )
               ),
               tabPanel("Ratings",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput("plot2Select",
                                            label = h3("Select a Genre"),
                                            choices = CHOICE)
                            ),
                            mainPanel(
                                plotOutput("plot2")#,
                                # textOutput("p2Text")
                            )
                        )
               ),
               tabPanel("Budget",
                        sidebarLayout(
                            sidebarPanel(
                                selectInput("plot3Select",
                                            label=h3("Select a Genre"),
                                            choices = CHOICE)
                            ),
                            mainPanel(
                                plotOutput("plot3")#,
                                # textOutput("p3Text")
                            )
                        )
               ),
               tabPanel("Revenue and Budget",
                        sidebarLayout(
                            sidebarPanel(
                                sliderInput("range",
                                            label = h3("Slider, Range in Millions"),
                                            min = 0,
                                            max = 400,
                                            value = c(0,400))
                            ),
                            mainPanel(
                                plotOutput("plot4")#,
                                # textOutput("p4Text")
                            )
                        )
                        
               ),
               tabPanel("About Us",
                        sidebarLayout(
                            sidebarPanel(
                                
                            ),
                            mainPanel(
                                textOutput("aboutText")
                            )
                        )
               )
    )
))