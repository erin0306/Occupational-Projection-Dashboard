library(dplyr)
library(shiny)
library(stringr)
library(plotly)
  
data <- read_excel("data/occupational_data_by_state.xlsx")
occ_groups <- filter(data, OCC_GROUP == "major")
occ <- data %>% filter(OCC_GROUP == "detailed")


shinyUI(fluidPage(
  
  titlePanel("2017 Occupational Data"),
  
  verticalLayout( 
    sidebarLayout(
      
      sidebarPanel(
        selectInput(inputId = "state",
                    label = "Select a state:",
                    choices = unique(data$STATE),
                    selected = "Alabama"),
        
        selectInput(inputId = "occ_group",
                    label = "Select an occupational group:",
                    choices = unique(occ_groups$OCC_TITLE),
                    selected = "Management Occupations")
        
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Total Employment", plotlyOutput("pie")),
          tabPanel("Mean Hourly Wage", plotlyOutput("hour")),
          tabPanel("Mean Annual Wage", "test"))
      )
    ),
    selectInput(inputId = "occ",
                label = "Look at a specific occupation",
                choices = unique(occ$OCC_TITLE))
  )
  
  
))
