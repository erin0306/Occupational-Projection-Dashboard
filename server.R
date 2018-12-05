library(shiny)
library(dplyr)
library(stringr)
library(readxl)

source("scripts/projection_graph.R")

my_server <- function(input, output, session) {
  
  ## All of our drop down menus link together.
  ## For the Employment Projection Tab
  ## UW major -> Type of Occupation -> Occupational Group -> Specific Occupation
  
  ## UW Major type-in observer
  ## AKA "Please type in your major:" observer
  observe({
    updated_text <- input$UW_major_text
    ## grep but first letter have to match
    matched_string <- uw_major_data$Major[tolower(substring(uw_major_data$Major, 1, nchar(updated_text))) == 
                                            tolower(updated_text)][1]
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "UW_major_dropdown",
                        selected = all_const)         
    } else {
      updateSelectInput(session, 
                        "UW_major_dropdown",
                        selected = matched_string)         
    }
   
    
  })


  ## UW Major drop down observer
  ## AKA "Please select your major:" observer
  observe({
    updated_UW_drop <- input$UW_major_dropdown
    if (updated_UW_drop == all_const) { ##All is selected, display all
      occ_list <- major_link
    } else {
      UW_major_row <- uw_major_data %>%
        filter(Major == updated_UW_drop)
      major_tag <- str_trim(UW_major_row$Tags)
      occ_list <- major_link %>%
        select(Jobs, major_tag) %>%
        filter(get(major_tag) == TRUE)
    }
    
    updateSelectInput(session, 
                      "occ_major",
                      choices = occ_list$Jobs)
      
  })

  ## Type of occupation type-in observer
  ## AKA "Type in your type of occupation here:" observer
  observe({
    updated_text <- input$occ_major_text
    ## grep but first letter have to match
    matched_string <- occ_major$Jobs[tolower(substring(occ_major$Jobs, 1, nchar(updated_text))) == 
                                       tolower(updated_text)][1]
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "occ_major",
                        selected = all_const)         
    } else {
      updateSelectInput(session, 
                        "occ_major",
                        selected = matched_string)         
    }
  })
  

  
  ## Major occupation to group occupation observer
  ## AKA "Select a type of occupation (Suggested based on your major):" observer
  observe({
    updated_major <- input$occ_major

    if (updated_major == all_const) {
      extract_row_groups <- occ_groups
    } else {
      ## Extrating the major row based on the label based on user input
      extract_row_major <- occ_major %>%
        filter(Jobs == updated_major)
      major_code <-  as.character(extract_row_major$layer1)
      extract_row_groups <- occ_groups %>%
        filter(layer1 == major_code)     
    }


    ## Update occupation group drop down based on major occupation input
    updateSelectInput(session, 
                      "occ_group",
                      choices = extract_row_groups$Jobs)
    
  })

  ## Group occupation to specific occupation Type-in observer
  ## AKA "Type in your occupational group here:" observer
  observe({
    updated_text <- input$occ_group_text
    ## grep but first letter have to match
    matched_string <- occ_groups$Jobs[tolower(substring(occ_groups$Jobs, 1, nchar(updated_text))) == 
                                       tolower(updated_text)][1]
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "occ_group",
                        selected = all_const)         
    } else {
      updateSelectInput(session, 
                        "occ_group",
                        selected = matched_string)         
    }
    
    
  })

  
  ## group occupation to specific occupation observer
  ## AKA "Select an occupational group:" observer
  ## observer for plots
  observe({
    updated_group <- input$occ_group
    limit <- input$limit_text
    
    if (limit == "" || is.na(as.numeric(limit))) {
      limit <- 20
    } else {
      limit <- as.numeric(limit)
    }
    
    if (updated_group == all_const) {
      extract_row_occ <-  occ
    } else {
      extract_group <- occ_groups %>%
        filter(Jobs == updated_group)
      occ_code_layer1 <- as.character(extract_group$layer1)
      occ_code_layer2 <- as.character(extract_group$layer2)
      extract_row_occ <- occ %>%
        filter(layer1 == occ_code_layer1) %>%
        filter(layer2 == occ_code_layer2)      
    }

    
    updateSelectInput(session, 
                      "occ",
                      choices = extract_row_occ$Jobs)
    

    ## Making 2016-2026 chart
    output$employment_projection <- renderPlotly({
      return(employment_projection_chart(extract_row_occ, limit))
    })
    
    ## Making 2017 median wage comparison chart
    output$median_wage_compare <- renderPlotly({
      return(median_wage_comparison(extract_row_occ, limit))
    })
  })

  ## specific occupation to specific occupation Type-in observer
  ## AKA "Type in your specific occupational here:" observer
  observe({
    updated_text <- input$occ_text
    updated_group <- input$occ_group
    
    if (updated_group == all_const) {
      extract_row_occ <-  occ
    } else {
      extract_group <- occ_groups %>%
        filter(Jobs == updated_group)
      occ_code_layer1 <- as.character(extract_group$layer1)
      occ_code_layer2 <- as.character(extract_group$layer2)
      extract_row_occ <- occ %>%
        filter(layer1 == occ_code_layer1) %>%
        filter(layer2 == occ_code_layer2)      
    }
    ## grep but first letter have to match
    matched_string <- extract_row_occ$Jobs[tolower(substring(extract_row_occ$Jobs, 1, nchar(updated_text))) == 
                                        tolower(updated_text)][1]
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "occ",
                        selected = all_const)         
    } else {
      updateSelectInput(session, 
                        "occ",
                        selected = matched_string)         
    }
    
    
  })  
  
  ## specific occupation to specific occupation observer
  ## AKA "Please select a specific occupation:" observer
  observe({
    updated_job <- input$occ
    
    # HTML debug
    #output$specific_source_code <- renderText({
    #  specific_table_information(occ, updated_job)
    #})
    
    output$specific_occupation <- renderUI(
    #tags$img(src = "www/Banchelor_Husky.PNG", width = 300, height = 300)
     HTML(specific_table_information(occ, updated_job))
    )
  })
  ### END OF EMPLOYMENT PROJECTION 

#############################################################################################################
  
  ## Type of occupation type-in observer
  ## AKA "Type in your occupational group here:" observer
  observe({
    updated_text <- input$occ_group_2017_text
    ## grep but first letter have to match
    matched_string <- occ_groups_2017$OCC_TITLE[tolower(substring(occ_groups_2017$OCC_TITLE, 1, nchar(updated_text))) == 
                                       tolower(updated_text)][1]
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "occ_group_2017",
                        selected = "")         
    } else {
      updateSelectInput(session, 
                        "occ_group_2017",
                        selected = matched_string)         
    }
  })
  
  ## Type of occupation type-in observer
  ## AKA "Type in your occupational title here:" observer
  observe({
    updated_text <- input$occupation_text
    update_group <- input$occ_group_2017
    update_state <- input$state
    
    # Get the row of the requested state from major occupational group data
    extract_row <- filter(filter(occ_groups_2017, OCC_TITLE == update_group), STATE == update_state)
    # Extract occupational code of that major occupational group
    occ_code <- substring(extract_row[1,4],1,3)
    # Create a new dataframe with only occupations from the requested state and group
    update_occ_data <- occ_2017 %>% filter(STATE == update_state) %>%
      filter(str_detect(OCC_CODE,occ_code))
    
    
    ## grep but first letter have to match
    matched_string <- update_occ_data$OCC_TITLE[tolower(substring(update_occ_data$OCC_TITLE, 1, nchar(updated_text))) == 
                                                  tolower(updated_text)][1]
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "occupation",
                        selected = "")         
    } else {
      updateSelectInput(session, 
                        "occupation",
                        selected = matched_string)         
    }
  })
  
  
  ## Erin
  observe({
    update_group <- input$occ_group_2017
    update_state <- input$state

    # Get the row of the requested state from major occupational group data
    extract_row <- filter(filter(occ_groups_2017, OCC_TITLE == update_group), STATE == update_state)
    # Extract occupational code of that major occupational group
    occ_code <- substring(extract_row[1,4],1,3)
    # Create a new dataframe with only occupations from the requested state and group
    update_occ_data <- occ_2017 %>% filter(STATE == update_state) %>%
      filter(str_detect(OCC_CODE,occ_code))

    ## Pie chart for total employment based on selected state
    output$pie <- renderPlotly({
      plot_ly(update_occ_data, 
              labels = ~OCC_TITLE, 
              values= ~TOT_EMP , 
              type = "pie",
              width = 1200, 
              textposition = "inside") %>%
        layout(font = list(size = 8))
    })
    
    ## Bar chart for mean hourly wage based on selected state
    output$hour <- renderPlotly({
      plot_ly(update_occ_data, 
              x = ~OCC_TITLE, 
              y = ~round(as.numeric(H_MEAN), digits = 2), 
              type = "bar",
              color = "plum",
              width = 1200) %>%
        layout(xaxis = list(title = "test",
                            ascending= TRUE),
               yaxis = list(title = "Count"))

    })
    
    # Bar chart for mean annual wage based on selected state
    output$annual_wage <- renderPlotly({
      plot_ly(update_occ_data, 
              x = ~OCC_TITLE, 
              y = ~as.numeric(A_MEAN), 
              type = "bar",
              width = 1200,
              marker = list(color = 'rgb(58,200,225)',
                            line = list(color = 'rgb(8,48,107)'))) %>%
        layout(xaxis = list(title = "test"),
               yaxis = list(title = "Count"))

    })
  })
  
  ## Alberto
  
  
  ## Type of occupation type-in observer
  ## AKA "Type in a State:" observer
  observe({
    updated_text <- input$state_text
    ## grep but first letter have to match
    matched_string <- data_2017$STATE[tolower(substring(data_2017$STATE, 1, nchar(updated_text))) == 
                                                  tolower(updated_text)][1]
    
    ## Matching State Acronym (WA -> washington, case insentitive)
    if (tolower(updated_text) %in% tolower(unique(data_2017$ST))) {
      matched_string <- as.character(data_2017 %>% 
        filter(ST == toupper(updated_text)) %>%
        select(STATE) %>%
        unique())
    }
    fullList <- (matched_string == "" || is.na(matched_string))
    if (fullList) {
      updateSelectInput(session, 
                        "state",
                        selected = "")         
    } else {
      updateSelectInput(session, 
                        "state",
                        selected = matched_string)         
    }
  })
  
  observe({
    update_group <- input$occ_group_2017
    
    # Get the row of the requested state from major occupational group data
    extract_row <- filter(filter(occ_groups_2017, OCC_TITLE == update_group), STATE == "Washington")
    # Extract occupational code of that major occupational group
    occ_code <- substring(extract_row[1, ]$OCC_CODE, 1, 3)
    # Create a new dataframe with only occupations from the requested state and group
    update_occ_data <- occ_2017 %>% filter(STATE == "Washington") %>%
      filter(str_detect(OCC_CODE, occ_code))
    
    # Updates the occupation widget
    updateSelectInput(session, "occupation",
                      choices = update_occ_data$OCC_TITLE
    )
    
  })
  
  ## TOTAL EMPLOYMENT CHOROPLETH
  observe({
    # Take in the input occupation field
    update_occ <- input$occupation
    # Filter based on input
    update_occ <- occ_2017 %>% filter(str_detect(OCC_TITLE, update_occ))
    
    # Maps out the total employment in each state with a choropleth of the U.S.A.
    output$USA_total_employment <-  renderPlotly({
      plot_ly(
        data = update_occ,
        type = "choropleth",
        locations = ~ST,
        locationmode = "USA-states",
        z = ~TOT_EMP,
        colorscale = "Reds") %>% 
        layout(geo = list(scope = "usa"))
    })
    
    # Maps out the hourly wage in each state with a choropleth of the U.S.A.
    output$USA_hourly_wage <-  renderPlotly({
      plot_ly(
        data = update_occ,
        type = "choropleth",
        locations = ~ST,
        locationmode = "USA-states",
        z = ~H_MEAN,
        colorscale = "YlGnBu") %>% 
        layout(geo = list(scope = "usa"))
    })
    
    # Maps out the annual wage in each state with a choropleth of the U.S.A.
    output$USA_annual_wage <-  renderPlotly({
      plot_ly(
        data = update_occ,
        type = "choropleth",
        locations = ~ST,
        locationmode = "USA-states",
        z = ~A_MEAN,
        colorscale = "Greens") %>% 
        layout(geo = list(scope = "usa"))
    })
  })
    
}

