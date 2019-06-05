library(shiny)

CHOICE <- c("Action" = "Action", "Adventure" = "Adventure",
           "Comedy" = "Comedy", "Documentary" = "Documentary",
           "Drama" = "Drama", "Horror" = "Horror", "Romance" = "Romance",
           "Sci-Fi" = "Science Fiction", "Thriller" = "Thriller")
shinyUI(fluidPage(
    
    theme = "projectStyle.css",
    img(src = "filmstrip.png", alt = "filmstrip"),
    
    # Application title
    titlePanel("Film Statistics in Reference to Genre and Budget"),
    
    # Code containing the top level navigation bar. Pages grouped as "Summary," 
    # "Revenue," "Ratings," "Budget," "Revenue and Budget," and "About Us"
    
    # "Revenue," "Ratings," and "Budget" all contain selectInput in order
    # to determine which genre is examined.
    
    # "Revenue and Budget" contains a slider that determines the Budget range
    # to be used for the X-axis of the plot.
    
    # Each plot is followed by an insertMarkdown command containing text that
    # provides some insight/summary information into the data shown by the plot.
    navbarPage("Group LSD",
               tabPanel("Summary",
                        mainPanel(
                            includeMarkdown("website_README/summaryREADME.md")
                        )
               ),
               tabPanel("Revenue",
                        fluidRow(
                            column(4,
                                div(class = "widget",
                                    selectInput("plot1Select",
                                                label = h3("Select a Genre"),
                                                choices = CHOICE)
                                ),
                                includeMarkdown("website_README/plot1README.md")
                            ),
                            column(8,
                                div(class = "panel",
                                plotOutput("plot1"),
                                textOutput("p1Text")
                                )
                            )
                        )
               ),
               tabPanel("Ratings",
                        fluidRow(
                            column(4,
                                div(class = "widget",
                                selectInput("plot2Select",
                                            label = h3("Select a Genre"),
                                            choices = CHOICE)
                                ),
                                includeMarkdown("website_README/plot2README.md")
                            ),
                            column(8,
                                div(class = "panel",
                                plotOutput("plot2"),
                                textOutput("p2Text")
                                )
                            )
                        )
               ),
               tabPanel("Budget",
                        fluidRow(
                            column(4,
                                div(class = "widget",
                                selectInput("plot3Select",
                                            label=h3("Select a Genre"),
                                            choices = CHOICE)
                                ),
                                includeMarkdown("website_README/plot3README.md")
                            ),
                            column(8,
                                div(class = "panel",
                                plotOutput("plot3"),
                                textOutput("p3Text")
                                )
                            )
                        )
               ),
               tabPanel("Revenue versus Budget",
                        fluidRow(
                            column(4,
                                div(class = "widget",
                                sliderInput("range",
                                            label = h3("Slider, Range in Millions"),
                                            min = 0,
                                            max = 400,
                                            value = c(0,400))
                                ),
                                includeMarkdown("website_README/plot4README.md")
                            ),
                            column(8,
                                div(class = "panel",
                                plotOutput("plot4")
                                )
                            )
                        )
                        
               ),
               tabPanel("About Us",
                        fluidRow(
                            column(9,
                                div(class = "about",
                                    includeMarkdown("website_README/aboutREADME.md")
                                )
                            ),
                            column(3,
                                img(src = "spotlight.png", alt = "spotlight")
                            )
                        )
               )
    )
))