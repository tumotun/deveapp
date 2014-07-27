library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Hospital Outcome of Care Measures"),
    sidebarPanel(
      radioButtons("options", "Category:",
                   list("Mortality" = "mor",
                        "Readmission" = "read")),
      sliderInput("rankpercent", "Rank Percentile (lower is better):", 
                  min = 0, max = 100, value = 20),
      selectInput("dataset", "State:", as.list(c("All", "NY", "PA", "CA", "SD", "CT", "IL", "IN", "MI", "NJ", "WI", "AR", "RI", "AZ", "MO", "OH", "TX", "MA", "MN", "FL", "KY", "ID", "NH", "CO", "MD","IA", "OK", "OR", "VA", "ME", "TN", "DE", "GA", "MS", "SC", "ND", "WA", "KS", "NC", "UT", "AL", "HI", "AK", "NV", "LA", "MT", "NM", "DC", "NE","PR", "WV", "VT", "VI", "WY", "GU")))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Heart Attack", 
                 h3("Rank of Hospital in Heart Attack"),
                 verbatimTextOutput("list4hearta")
        ),
        tabPanel("Heart Failure",
                 h3("Rank of Hospital in Heart Failure"),
                 verbatimTextOutput("list4heartf")
        ),
        tabPanel("Pneumonia",
                 h3("Rank of Hospital in Pneumonia"),
                 verbatimTextOutput("list4penu")
        )
      )
    )
  )
)