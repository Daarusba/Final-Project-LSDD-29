library(shiny)

CHOICE <- c("Action" = "Action", "Adventure" = "Adventure",
           "Comedy" = "Comedy", "Documentary" = "Documentary",
           "Drama" = "Drama", "Horror" = "Horror", "Romance" = "Romance",
           "Sci-Fi" = "Science Fiction", "Thriller" = "Thriller")
shinyUI(fluidPage(
    
    theme = "projectStyle.css",
    img(src = "filmstrip.png", alt = "filmstrip"),
    
    # Application title
    titlePanel("Final Project"),
    
    # Code containing the top level navigation bar. Pages grouped as "Summary," 
    # "Revenue," "Ratings," "Budget," "Revenue and Budget," and "About Us"
    navbarPage("Group LSD",
               tabPanel("Summary",
                        mainPanel(
                            includeMarkdown("website_README/summaryREADME.md")
                        )
               ),
               tabPanel("Revenue",
                        sidebarLayout(
                            sidebarPanel(
                                div(class = "widget",
                                    selectInput("plot1Select",
                                                label = h3("Select a Genre"),
                                                choices = CHOICE)
                                )
                            ),
                            mainPanel(
                                div(class = "panel",
                                plotOutput("plot1")#,
                                # textOutput("p1Text")
                                )
                            )
                        )
               ),
               tabPanel("Ratings",
                        sidebarLayout(
                            sidebarPanel(
                                div(class = "widget",
                                selectInput("plot2Select",
                                            label = h3("Select a Genre"),
                                            choices = CHOICE)
                                )
                            ),
                            mainPanel(
                                div(class = "panel",
                                plotOutput("plot2")#,
                                # textOutput("p2Text")
                                )
                            )
                        )
               ),
               tabPanel("Budget",
                        sidebarLayout(
                            sidebarPanel(
                                div(class = "widget",
                                selectInput("plot3Select",
                                            label=h3("Select a Genre"),
                                            choices = CHOICE)
                                )
                            ),
                            mainPanel(
                                div(class = "panel",
                                plotOutput("plot3")#,
                                # textOutput("p3Text")
                                )
                            )
                        )
               ),
               tabPanel("Revenue and Budget",
                        sidebarLayout(
                            sidebarPanel(
                                div(class = "widget",
                                sliderInput("range",
                                            label = h3("Slider, Range in Millions"),
                                            min = 0,
                                            max = 400,
                                            value = c(0,400))
                                )
                            ),
                            mainPanel(
                                div(class = "panel",
                                plotOutput("plot4")#,
                                # textOutput("p4Text")
                                )
                            )
                        )
                        
               ),
               tabPanel("About Us",
                            mainPanel(
                                includeMarkdown("website_README/aboutREADME.md")
                            )
               )
    )
))