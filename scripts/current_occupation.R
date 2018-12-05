## Erin
current_occ <- tabItem(
  tabName = "curr_occ_tab",
  titlePanel("2017 Occupational Data"),
  fluidRow(

    box(width = 2,
        title = "Occupation Widget",
        status = "warning",
        solidHeader = TRUE,
        textInput(inputId = "occ_group_2017_text",
                  label = "Type in your occupational group here:",
                  value = NULL),
        
        selectInput(inputId = "occ_group_2017",
                    label = "Select an occupational group:",
                    choices = unique(occ_groups_2017$OCC_TITLE),
                    selected = "Management Occupations"),
        
        ## Alberto
        textInput(inputId = "occupation_text",
                  label = "Type in your occupational title here:",
                  value = NULL),
        
        selectInput(inputId = "occupation",
                    label = strong("Occupational Title"),
                    choices = unique(occ$OCC_TITLE)
        )
    ),
    ## Alberto
    box(width = 10,
        title = "Map",
        status = "info",
        solidHeader = TRUE,
        tabsetPanel(
          tabPanel("Total Employment", plotlyOutput("USA_total_employment")),
          tabPanel("Hourly Wage", plotlyOutput("USA_hourly_wage")),
          tabPanel("Annual Wage", plotlyOutput("USA_annual_wage"))
        )        
    ),
    
    ## Select state widget
    ## Erin
    box(width = 2,
        title = "State Widget",
        status = "warning",
        solidHeader = TRUE,
        ## Erin
        textInput(inputId = "state_text",
                  label = "Type in a State:",
                  value = NULL),
        selectInput(inputId = "state",
                    label = "Select a State:",
                    choices = unique(data_2017$STATE),
                    selected = "Alabama")
    ), 
    
    ## Erin
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

