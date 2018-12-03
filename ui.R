library(shinydashboard)
library(dplyr)
library(shiny)
library(stringr)

source("scripts/projection.R")
source("Scripts/overview.R")

my_ui <- dashboardPage(
  dashboardHeader(title = "Employment Data"),
  dashboardSidebar(sidebarMenu(
    menuItem("Overview", tabName = "overview_tab", icon = icon("home")),
    menuItem("Employment Projection", tabName = "projection_tab", icon = icon("bar-chart"))
  )),
  dashboardBody(
    tabItems(
      overview,
      employment_projection
    ))
)


shinyUI(my_ui)

