library(shinydashboard)
library(dplyr)
library(shiny)
library(stringr)

source("scripts/projection.R")

my_ui <- dashboardPage(
  dashboardHeader(title = "Employment Data"),
  dashboardSidebar(sidebarMenu(
    menuItem("Employment Projection", tabName = "projection_tab", icon = icon("bar-chart"))
  )),
  dashboardBody(
    tabItems(
      employment_projection
    ))
)


shinyUI(my_ui)

