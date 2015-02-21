library(shiny)
shinyUI(fluidPage(
        titlePanel("Probability of Being Male"),
        sidebarLayout(
                sidebarPanel(
                        h4("This web site computes the probablity of a USA-born person 
                           being male based on their name and 
                           approximate birth date"),
                        textInput("name", label="First Name:"),  
                        h4("Minimum year and maximum year is where you enter a 
                           range of years between which you believe that person was 
                           born"),
                        numericInput("min_year",
                                     "Minimum Year of Birth:",
                                     value = 1890,min=1880,max=2013),
                        numericInput("max_year",
                                     "Maximum Year of Birth:",
                                     value = 2013,min=1880,max=2013)
                        ),
                mainPanel(
                        h3(textOutput("probability"))
                )
        )
))
