library(shiny)
library(dplyr)
library(stringr)

source("scripts/projection_graph.R")

my_server <- function(input, output, session) {
  
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
    

    
    output$employment_projection <- renderPlotly({
      return(employment_projection_chart(extract_row_occ, limit))
    })
    
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
    
    #output$specific_source_code <- renderText({
    #  specific_table_information(occ, updated_job)
    #})
    
    output$specific_occupation <- renderUI(
    #tags$img(src = "www/Banchelor_Husky.PNG", width = 300, height = 300)
     HTML(specific_table_information(occ, updated_job))
    )
  })
  

    
}
  
shinyServer(my_server)