## ui.R ##

library(shinydashboard)
library(leaflet)


sidebar <- dashboardSidebar(
  sidebarMenu(
    
    #setting id makes input$tabs give the tabName o fcurrently-selected tab
    id = "tabs",
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green")
    
  )
)

body <- dashboardBody(
  tabItems(
    
    
  )
)

# Put them together into a dashboardPage
dashboardPage(
  dashboardHeader(title = "Mixed layout"),
  dashboardSidebar(),
  body
)

