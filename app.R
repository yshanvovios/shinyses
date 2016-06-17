## app.R ##
library(shinydashboard)

ui <- dashboardPage(
  
  dashboardHeader(
    title = "Scheduler Expert Systems",
    titleWidth = 300,
    
    # for Dynamic Content a
    # dropdownMenuOutput("messageMenu"),
    
    dropdownMenu(type = "messages",
                 messageItem(
                   from = "Sales Dept",
                   message = "Sales are steady this month."
                 ),
                 messageItem(
                   from = "New User",
                   message = "How do I register?",
                   icon = icon("question"),
                   time = "13:45"
                 ),
                 messageItem(
                   from = "Support",
                   message = "The new server is ready.",
                   icon = icon("life-ring"),
                   time = "2016-06-16"
                 )
    ),
    
    # Dropdown menu for notifications
    dropdownMenu(type = "notifications", badgeStatus = "warning",
                 notificationItem(icon = icon("users"), status = "info",
                                  "5 new members joined today"
                 ),
                 notificationItem(icon = icon("warning"), status = "danger",
                                  "Resource usage near limit."
                 ),
                 notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
                                  status = "success", "25 sales made"
                 ),
                 notificationItem(icon = icon("user", lib = "glyphicon"),
                                  status = "danger", "You changed your username"
                 )
    ),
    
    # Dropdown menu for tasks, with progress bar
    dropdownMenu(type = "tasks", badgeStatus = "danger",
                 taskItem(value = 20, color = "aqua",
                          "Refactor code"
                 ),
                 taskItem(value = 40, color = "green",
                          "Design new layout"
                 ),
                 taskItem(value = 60, color = "yellow",
                          "Another task"
                 ),
                 taskItem(value = 80, color = "red",
                          "Write documentation"
                 )
    )
    
    
  ),
  
  ## Sidebar
  dashboardSidebar(
    width = 300,
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th")),
      menuItem("charts", tabName = "charts", icon = icon("area-chart"))
      
    )
  ),
  
  ## Body content
  dashboardBody(
    
    # A
    # Also add some custom CSS to make the title background area the same
    # color as the rest of the header.
    tags$head(tags$style(HTML('
                              .skin-blue .main-header .logo {
                              background-color: #3c8dbc;
                              }
                              .skin-blue .main-header .logo:hover {
                              background-color: #3c8dbc;
                              }
                              '))),
    
    
    
    
    
    
    
    
    
    # histogram and control
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              
              # infoBoxes with fill=FALSE
              # fluidRow(
              #   # A static infoBox
              #   infoBox("New Orders", 10 * 2, icon = icon("credit-card")),
              #   # Dynamic infoBoxes
              #   infoBoxOutput("progressBox"),
              #   infoBoxOutput("approvalBox")
              # ),
              
              # infoBoxes with fill=TRUE
              fluidRow(
                infoBox("New Orders", 10 * 2, icon = icon("credit-card"), fill = TRUE),
                infoBoxOutput("progressBox2"),
                infoBoxOutput("approvalBox2")
              ),
              fluidRow(
                # Clicking this will increment the progress amount
                box(width = 4, actionButton("count", "Increment progress"))
              ),
              
              fluidRow(
                box(plotOutput("plot1", height = 250)),
                
                box(
                  title = "Controls",
                  sliderInput("slider", "Number of observations:", 1, 100, 50)
                )
              ),
              
              fluidRow(
                box(
                  title = "Box title", width = 6, status = "primary",
                  "Box content"
                ),
                box(
                  status = "warning", width = 6,
                  "Box content"
                )
              )
              
      ),
      
      
      
      
      
      # Second tab content
      tabItem(tabName = "widgets",
              
              shinyUI(navbarPage("Widgets",
                                 tabPanel("Component 1"),
                                 tabPanel("Component 2"),
                                 navbarMenu("More",
                                            tabPanel("Sub-Component A"),
                                            tabPanel("Sub-Component B"))
              ))
              
              
      ),
      
      tabItem(tabName = "chart",
              shinyUI(navbarPage("Charts",
                                 tabPanel("Component 1"),
                                 tabPanel("Component 2"),
                                 navbarMenu("More",
                                            tabPanel("Sub-Component A"),
                                            tabPanel("Sub-Component B"))
              ))
      )
      
      
      
      
    )
  )
)



server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  # fill=false background is white
  # output$progressBox <- renderInfoBox({
  #   infoBox(
  #     "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
  #     color = "purple"
  #   )
  # })
  # output$approvalBox <- renderInfoBox({
  #   infoBox(
  #     "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
  #     color = "yellow"
  #   )
  # })
  
  # Same as above, but with fill=TRUE
  output$progressBox2 <- renderInfoBox({
    infoBox(
      "Progress", paste0(25 + input$count, "%"), icon = icon("list"),
      color = "purple", fill = TRUE
    )
  })
  output$approvalBox2 <- renderInfoBox({
    infoBox(
      "Approval", "80%", icon = icon("thumbs-up", lib = "glyphicon"),
      color = "yellow", fill = TRUE
    )
  })
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  
  
  
  # For Dynamic Content
  # output$messageMenu <- renderMenu({
  #   # Code to generate each of the messageItems here, in a list. This assumes
  #   # that messageData is a data frame with two columns, 'from' and 'message'.
  #   msgs <- apply(messageData, 1, function(row) {
  #     messageItem(from = row[["from"]], message = row[["message"]])
  #   })
  #   
  #   # This is equivalent to calling:
  #   #   dropdownMenu(type="messages", msgs[[1]], msgs[[2]], ...)
  #   dropdownMenu(type = "messages", .list = msgs)
  # })
}

shinyApp(ui, server)