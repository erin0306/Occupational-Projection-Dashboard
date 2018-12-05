## Erin
current_occ <- tabItem(
  tabName = "curr_occ_tab",
  titlePanel("2017 Occupational Data"),
  fluidRow(

    box(width = 2,
        title = "Occupation Widget",
        status = "warning",
        solidHeader = TRUE,
        
        ## Occupational Group type-in
        ## What you type here will change the Occupational Group drop-down
        textInput(inputId = "occ_group_2017_text",
                  label = "Type in your occupational group here:",
                  value = NULL),
        
        ## Occupational Group
        ## What you selected here will change the available Specific Occupation options
        selectInput(inputId = "occ_group_2017",
                    label = "Select an occupational group:",
                    choices = unique(occ_groups_2017$OCC_TITLE),
                    selected = "Management Occupations"),
        
        ## Alberto
        ## Specific Occupation type-in
        ## What you type here will change the Specific Occupation drop-down
        textInput(inputId = "occupation_text",
                  label = "Type in your specific occupation here:",
                  value = NULL),
        
        ## Specific Occupation
        ## What you selected here will change the U.S.A total employment, hourly and annual wage map.
        selectInput(inputId = "occupation",
                    label = strong("Specific Occupation"),
                    choices = unique(occ_2017$OCC_TITLE)
        )
    ),
    ## Alberto
    
    ## U.S.A total employment, hourly and annual wage map
    box(width = 10,
        title = "Map",
        status = "info",
        solidHeader = TRUE,
        tabsetPanel(
          tabPanel("Total Employment", plotlyOutput("USA_total_employment")),
          tabPanel("Hourly Wage", plotlyOutput("USA_hourly_wage")),
          tabPanel("Annual Wage", plotlyOutput("USA_annual_wage"))
        )        
    )
  ),
  
  fluidRow(
    
    ## Select state widget
    ## Erin
    box(width = 2,
        title = "State Widget",
        status = "warning",
        solidHeader = TRUE,
        ## Erin
        ## State type-in
        ## What you type here will change the State drop-down
        textInput(inputId = "state_text",
                  label = "Type in a State:",
                  value = NULL),
        
        ## State drop-down
        ## What you selected here will change the State-specific total employment, hourly and annual wage chart
        selectInput(inputId = "state",
                    label = "Select a State:",
                    choices = unique(data_2017$STATE),
                    selected = "Alabama")
    ), 
    
    ## Erin
    
    ## State-specific total employment, hourly and annual wage chart
    box(width = 10,
        title = "2017 Occupational Data",
        status = "info",
        solidHeader = TRUE,
        mainPanel(
          tabsetPanel(
            tabPanel("Total Employment", plotlyOutput("pie")),
            tabPanel("Mean Hourly Wage", plotlyOutput("hour")),
            tabPanel("Mean Annual Wage", plotlyOutput("annual_wage")))
        )
    )
  )
)

