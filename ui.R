library(shinydashboard)
library(dplyr)
library(shiny)
library(stringr)

source("scripts/projection.R")
source("scripts/overview.R")
source("scripts/current_occupation.R")

my_ui <- dashboardPage(
  
  skin = "purple",
  dashboardHeader(title = "Employment Data"),
  dashboardSidebar(sidebarMenu(
    menuItem("Overview", tabName = "overview_tab", icon = icon("home")),
    menuItem("Employment Projection", tabName = "projection_tab", icon = icon("chart-line")),
    menuItem("Current Occupation", tabName = "curr_occ_tab", icon = icon("pie-chart"))
  )),
  dashboardBody(
    tabItems(
      overview,
      employment_projection,
      current_occ
    ))
)


shinyUI(my_ui)

