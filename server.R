
library(shiny)
library(fivethirtyeight)
library(dplyr)
data(college_all_ages)
grouped_data <- group_by(college_all_ages, major_category)
data <- summarise(grouped_data, median=median(median), unemployment_rate = mean(unemployment_rate))
names <- unique(data$major_category)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        output$distPlot <- renderPlot({
                plot(data$median, data$unemployment_rate,
                        xlab="Median Income",
                        ylab="Unemployment Rate"
                        )
                points(data$median[data$major_category==input$rd],
                        data$unemployment_rate[data$major_category==input$rd],
                        pch = 16, 
                        col = "Red"
                        )
        output$text1 <- renderText(paste("The unemployment rate for the selected category is", 
                                         100*(signif(data$unemployment_rate[data$major_category==input$rd], digits = 2)), "%."
                                         )
                                )
        output$text2 <- renderText(paste("The median income for the selected category is $", 
                                         data$median[data$major_category==input$rd], "."
                                        )
                                )
  })
  
})
