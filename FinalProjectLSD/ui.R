#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

CHOICE <- c("Horror","Comedy","Action","Romance","Thriller","Sci-fi","Drama","Documentary","All")
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Final Project"),
  
  # Sidebar with a slider input for number of bins
  navbarPage("Home",
             tabPanel("Summary"
                      
             ),
             tabPanel("Plot1",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("Plot1select",
                                      label = h3("Selectbox"),
                                      choices = CHOICE)
                        ),
                        mainPanel(
                          plotOutput("plot1")
                        )
                      )
             ),
             tabPanel("Plot2",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("Plot2select",
                                      label = h3("Selectbox"),
                                      choices = CHOICE)
                        ),
                        mainPanel(
                          plotOutput("plot2")
                        )
                      )
             ),
             tabPanel("Plot3",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput("Plot3select",
                                      label=h3("Selectbox"),
                                      choices = CHOICE)
                        ),
                        mainPanel(
                          plotOutput("plot3")
                        )
                      )
             ),
             tabPanel("Plot4",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput("range",
                                      label = h3("Slider Range in Millions"),
                                      min = 0,
                                      max = 400,
                                      value = c(0,400))
                        ),
                        mainPanel(
                          plotOutput("plot4")
                        )
                      )
               
             ),
             tabPanel("About Us",
                      sidebarLayout(
                        sidebarPanel(
                          
                        ),
                        mainPanel(
                          textOutput("about")
                        )
                      )
             )
  )
))
