library(dplyr)
library(shiny)
library(plotly)
library(shinydashboard)

## Nam
employment_projection <- tabItem(
  tabName = "projection_tab",
  
  titlePanel("2016 - 2026 Occupational Projection"),
  fluidRow(
    
    box(width = 2,
        title = "Widget", 
        status = "success",
        solidHeader = TRUE,
        textInput(inputId = "UW_major_text",
                  label = "Type in your major here:",
                  value = NULL),
        
        selectInput(inputId = "UW_major_dropdown",
                    label = "Please select your major:",
                    choices = unique(uw_major_data$Major),
                    selected = "All"),
 
        textInput(inputId = "occ_major_text",
                  label = "Type in your type of occupation here:",
                  value = NULL),
               
        selectInput(inputId = "occ_major",
                    label = "Please select a type of occupation (Suggested based on your major):",
                    choices = unique(occ_major$Jobs),
                    selected = "All"),
        
        textInput(inputId = "occ_group_text",
                  label = "Type in your occupational group here:",
                  value = NULL),
        
        
        selectInput(inputId = "occ_group",
                    label = "Please select an occupational group:",
                    choices = unique(occ_groups$Jobs),
                    selected = "Top executives"),
        
        textInput(inputId = "occ_text",
                  label = "Type in your specific occupational here:",
                  value = NULL),
        
        selectInput(inputId = "occ",
                    label = "Please select a specific occupation:",
                    choices = unique(occ$Jobs),
                    selected = "Chief executives"),
        
        textInput(inputId = "limit_text",
                  label = "Please type in a limit for how many data point is displayed on graph (Default is 20):",
                  value = "20")
        
    ),
  
    box(title = "2016 and 2026 employment projection between occupational group", 
        status = "primary", 
        width = 10, 
        solidHeader = TRUE,
        plotlyOutput("employment_projection")
    ),
    
    box(title = "2017 median wage comparison between occupational group",
        status = "primary",
        width = 10,
        solidHeader = TRUE,
        plotlyOutput("median_wage_compare")
    ),
    
    box(title = "Your specific occupation",
        status = "primary",
        width = 12,
        solidHeader = TRUE,
        #textOutput("specific_source_code"),
        uiOutput("specific_occupation")
    )
  )
  
)
