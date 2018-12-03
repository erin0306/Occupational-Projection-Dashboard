library(shiny)
library(dplyr)
library(readxl)
library(plotly)

shinyServer(function(input, output, session) {
  
  data <- read_excel("data/occupational_data_by_state.xlsx") 
  occ_groups <- filter(data, OCC_GROUP == "major")
  occ <- data %>% filter(OCC_GROUP == "detailed")
  
  observe({
    update_group <- input$occ_group
    update_state <- input$state
    
    # Get the row of the requested state from major occupational group data
    extract_row <- filter(filter(occ_groups, OCC_TITLE == update_group), STATE == update_state)
    # Extract occupational code of that major occupational group
    occ_code <- substring(extract_row[1,4],1,3)
    # Create a new dataframe with only occupations from the requested state and group
    update_occ_data <- occ %>% filter(STATE == update_state) %>%
      filter(str_detect(OCC_CODE,occ_code))
    
    updateSelectInput(session, "occ",
                      choices = update_occ_data$OCC_TITLE
    )
    
    output$pie <- renderPlotly({
      plot_ly(update_occ_data, labels = ~OCC_TITLE, values= ~TOT_EMP , type = 'pie',width = 850, textposition = 'inside') %>%
        layout(font = list(size = 8))
    })
    output$hour <- renderPlotly({
      plot_ly(update_occ_data, x = ~OCC_TITLE, y = ~H_MEAN, type = 'bar') %>%
        layout(xaxis = list(title = "test",
                            ascending= TRUE),
               yaxis = list(title = "Count"))
      
    })
    output$annual_wage <- renderPlotly({
      plot_ly(update_occ_data, x = ~OCC_TITLE, y = ~A_MEAN, type = 'bar') %>%
        layout(xaxis = list(title = "test"),
               yaxis = list(title = "Count"))
      
    })
      
  })
  
})
