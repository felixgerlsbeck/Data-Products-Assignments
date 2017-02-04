#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(fivethirtyeight)
library(dplyr)
data(college_all_ages)
grouped_data <- group_by(college_all_ages, major_category)
data <- summarise(grouped_data, median=median(median), unemployment_rate = mean(unemployment_rate))
names <- unique(data$major_category)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  # Application title
  titlePanel("Median Earnings and Unemployment Rate for Different College Major Categories"),
  sidebarLayout(
    sidebarPanel(
            h3("Select College Major"),
            radioButtons("rd", "Major", choices = names)
    ),
    # Show a plot of the generated distribution
    mainPanel(
            h4("Select a category of college major on the left. The red point in the plot below shows the average unemployment rate and median income for the selected category of college majors. The data is from fivethirtyeight.com"),
            plotOutput("distPlot"),
            textOutput("text1"),
            textOutput("text2")
    )
  )
))
