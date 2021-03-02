library(tidyverse)
library(shiny)
library(shinydashboard)

UC_admit <- readr::read_csv("data/UC_admit.csv")
UC_admit <- clean_names(UC_admit)

ui <- dashboardPage(
  dashboardHeader(title = "UC Admissions"),
  dashboardSidebar(disable = F),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          radioButtons("x", "Select Year", choices = c("2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019"), 
                       selected = "2019"),
          selectInput("y", "Select Campus", choices = c("Davis", "Irvine", "Berkeley", "Los_Angeles", "Merced", "Riverside", "San_Diego", "Santa_Barbara", "Santa_Cruz"),
                      selected = "Davis"),
          selectInput("z", "Select Admit Category", choices = c("Applicants", "Admits", "Enrollees"),
                      selected = "Applicants"),
      ), # close the first box
      box(title = "UC Admissions by Ethnicity", width=7,
          plotOutput("plot", width = "550px", height = "500px")
      ) # close the second box
    ) # close the row
  ) # close the dashboard body
) # close the ui

server <- function(input, output, session) { 
  
  output$plot <- renderPlot({
    UC_admit %>% 
      filter(academic_yr==input$x & campus==input$y & category==input$z) %>% 
      ggplot(aes(x=reorder(ethnicity, filtered_count_fr), y=filtered_count_fr)) + 
      geom_col(color="black", fill="goldenrod", alpha=1)+
      theme_grey()+
      theme(axis.text.x = element_text(size = 11, angle = 60, hjust = 1)) +
      theme(axis.text.y = element_text(size=11, hjust =1)) +
      labs(x = "Ethnicity", y = "Number in Category")
    
  })
  
  # stop the app when we close it
  session$onSessionEnded(stopApp)
}

shinyApp(ui, server)
