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
                  label = "Please type in your major:",
                  value = NULL),
        
        selectInput(inputId = "UW_major_dropdown",
                    label = "Please select your major:",
                    choices = unique(uw_major_data$Major),
                    selected = "All"),
        
        selectInput(inputId = "occ_major",
                    label = "Please select a type of occupation (Suggested based on your major):",
                    choices = unique(occ_major$Jobs),
                    selected = "All"),
        
        selectInput(inputId = "occ_group",
                    label = "Please select an occupational group:",
                    choices = unique(occ_groups$Jobs),
                    selected = "Top executives"),
        
        selectInput(inputId = "occ",
                    label = "Please select a specific occupation:",
                    choices = unique(occ$Jobs),
                    selected = "Chief executives"),
        
        textInput(inputId = "limit_text",
                  label = "Please type in a limit for how many data point is displayed on graph (Default is 20):",
                  value = "20")
        
    ),
  
    box(title = "2016 and 2026 employment projection", 
        status = "primary", 
        width = 10, 
        solidHeader = TRUE,
        plotlyOutput("employment_projection")
    ),
    
    box(title = "2017 median wage comparison",
        status = "primary",
        width = 10,
        solidHeader = TRUE,
        plotlyOutput("median_wage_compare")
    ),
    
    box(title = "Your specific job",
        status = "primary",
        width = 12,
        solidHeader = TRUE,
        #textOutput("specific_source_code"),
        uiOutput("specific_occupation")
    )
  )
  
)
