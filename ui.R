## ui.R ##

library(shinydashboard)
library(leaflet)


sidebar <- dashboardSidebar(
  sidebarMenu(
    
    #setting id makes input$tabs give the tabName o fcurrently-selected tab
    id = "tabs",
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", icon = icon("th"), tabName = "widgets",
             badgeLabel = "new", badgeColor = "green"),
    menuItem("Charts", tabName = "charts", icon = icon("area-chart"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            h2("Dashboard tab content")
    ),
    
    tabItem(tabName = "widgets",
            h2("Widgets tab content")
    ),
    
    tabItem(tabName = "charts",
            h2("Charts tab content"))
  )
)

# Put them together into a dashboardPage
dashboardPage(
  dashboardHeader(title = "Mixed layout"),
  dashboardSidebar(),
  body
)
